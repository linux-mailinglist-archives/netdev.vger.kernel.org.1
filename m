Return-Path: <netdev+bounces-283448-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id JnLvBc8y9mkLTAIAu9opvQ
	(envelope-from <netdev+bounces-283448-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 19:22:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D934B307C
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 19:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F053300C008
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 17:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A003033EA;
	Sat,  2 May 2026 17:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hvP55usX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296D7155C97
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 17:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777742540; cv=pass; b=prUuRuVzi8xOuMOkB8ukFvYRBPKlZUmzYDj73CkA0Qkmt26yh/hraOYQoMRtvOU450UfvjGPqzDnv4Kf78+ppmHEqffIy1oW2PoXFROrhKNUW8/igSvzZ9hsLDCaWzqhYiVlqJNwc0n1brqXFnmeopGoumicudYrkDaTAU7H+vI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777742540; c=relaxed/simple;
	bh=hzlKEZieuX665PXRSN9cb5s5g1iCk0kMYnOSLzI3MII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IbWJmhLJg0z28pfkvArIFuNXvbolvl+IiWA2CrWvbtgMeQ0ZKWNtdKUNwr3HP0ZBW9dypw3eDvrUs7lbQWnXFy/M6pDTNHaJrcju5vzcPC7IEgg/pwAeDwghdLdl3MFuRuuoSXNVBO1A6KZEnQ1n9F3wwjnFvjKSK8sbZhrQt58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hvP55usX; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50fb18c55beso28443261cf.2
        for <netdev@vger.kernel.org>; Sat, 02 May 2026 10:22:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777742538; cv=none;
        d=google.com; s=arc-20240605;
        b=kfINLljWpc68iUBn2muBFuughNPIc51RHRZLjQwoWwDfNF8wHZQuN8NU3ChWzW8BQ8
         oQ4sjbzUpxLuiTzR7sStF/97w+MulGdj5Pdui65R3UAXWdym/aJ7Qh+x8DHapx+QraTw
         JFLPiZV1iMwH1HphrfuDVuwa8os6+oagg0KD7+CGC0Fp4zc9X3ABqpzrKGV8IKfsNFlb
         kmtv2joyEO863X1K8RTWq/1EzBpVR9381u96NM0wcJJzfVK2TKJgADf4yzFqOFErMHIO
         ebXuReVwKZUsjn5bHc39AOq37iihTOBXTN8ZKWecULQo1DKxJg+ojkL2H6uREUGW7bax
         Aajg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tpDLBzhforPHF1ldl2VfP3FW81cMY29j0SUvp1IkuNQ=;
        fh=cSnMia7+t8AnTgIwSzT4yMHHU+51ijbfiWqgjJKc/LE=;
        b=SPRq6hgYhM9nZurnRyNSzTo2uEpo+1Q83Jps2DSOIT/aQ3gwhnOwmzUXPrMa3qUhvd
         INKCcxwRvpOym5An/35x9vHvoDWLkrQlYCLcG6v/E1u9sbWNr+CnpTPQuEKNSYId4IY2
         1SHu89yQKDD6TPSYT6lrTd5M3yS3p61YMsjYYbN2hHV1eXlYvb/ZNm4crkZBETSTzCsI
         QBffMi8MoZ5R4ZPPGtc0HpxotbyfimyDPN5NH+uMdiX4dZck3yJCTrDDsOz60iNxSJmi
         zvXARZF53zDLILjpoe6sOcBC2uWV9BPSR0DsSmmnW4e5Z9pFpWfqbwrYo09XirAsMHwX
         390A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777742538; x=1778347338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tpDLBzhforPHF1ldl2VfP3FW81cMY29j0SUvp1IkuNQ=;
        b=hvP55usXoEfD1InhOi317DiOA+YjwH/FpEdC+R/RfAZOJxcjLDDy8GCaSKEw5hBRUZ
         PItCH84kpIerU8G0t36RNoLvSqtKbTSSTKVAKghm5/CWRAW/zoRcYwZW2hVNbA41Vhjg
         1+KQl+oV1uVMHJoxtJ6UQFd8gfAD0z3INV3GTrX4uGwryKIC4DFYqQf/QarSdrheuT/F
         jyX6NBPCuHIeYtXdecQzBCsgllYPoU33T03kOgrEFAohOPxiBPuOiWhdRYiZr6CeH0yV
         /sKDL26IoaviUkk4fuHmDhy0EY9xR5WNFN6Wl72NzobwBs8qPp7TZcV2mkjUtPiUVxxf
         Nv3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777742538; x=1778347338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tpDLBzhforPHF1ldl2VfP3FW81cMY29j0SUvp1IkuNQ=;
        b=en2N0mHRAWmju1Bvydk6I03utGlDaMbYANEjJg8UBPkQbdgQNAzx4cOXpRxcSpuyiq
         ndrVDA2Au78Jdt6OL2evVRD9y6PDnahW2iu2gO1cN7Immh4qUg2KHVIvpKvvMov/j2T6
         1aKehEGBftExg1LYfAoClddRQfC/Sm1a2zPEcWd2rfKs13vCHwyL+0rpodCkFOraKOLh
         asSFmCfhjxe8mqcTmw0TzEaNrCz2LXOjlEjAVvYKIOLjGLcv1Vk8UDQIgun7cyDr4uXk
         bBpAxw8rGsaLywj67MVxun7O+SFuGNl0ZKnlP2kV+LJH/SDU7YkzwNmcQRWOCf/shD6F
         /VQA==
X-Forwarded-Encrypted: i=1; AFNElJ+JWjoDmwYYGJjMM7awIAwO6MbNZNJZD8WHaz1lC+fW0mK6yrA9dIx7E7YY5yZZKe6vYZPNAhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYQsu2NfHxB3atQgI5ddRvyrrb+61L7unV8trBZq7dwZ54B43k
	ZtSFL97B7w5CKyTz5IpyislM1OENWNM3n7WlglvBVzW9DdlXidefHmd6DMBcl/OUOMYQRvg4m9x
	L9ZRR6zdTsv9aRX3QI+0M32AaucKtLf5FAkLktMw3
X-Gm-Gg: AeBDietu9M1wwbGKc2qB0QXu3dB7krey0NwdclwwKSzwFkYtINqwEZ60o8eaLF8NXxs
	w+cPm6cq8EsS0/3mPnRGdQxfcvkfIWWSnJt7LGm7B86dP1tvjUuUT2fwOCWpZ32MrDb+dLJO8O/
	8BZ7Zirk2JtKooV78LVv9xn+HzhA5wCtqFDoMGMpy1JvrOSVSr+l3JKznZmpZYJPXJAL+ULQIBh
	629YE9YUbfOE7wTXghtMgSRUEPKZRprys4/5vUhcIt0kIGE6WlZB9hmF562BHTWzlPGp6PWnRwR
	gVY3Ow0UY/oB9JgpFrmMurvk8AEBInLXgHURnRBL558fECtrfuBA79yPN3/wNFLh8369NFePDWB
	PrIcmM4rXS1oRPkfWBEY+/6Kw96nufFlGEgMbgq6Ejc2s/gXDDco=
X-Received: by 2002:a05:622a:1ba9:b0:50d:e298:8f1c with SMTP id
 d75a77b69052e-5104bee9d67mr56732281cf.32.1777742537586; Sat, 02 May 2026
 10:22:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260501064247.2027688-1-edumazet@google.com>
In-Reply-To: <20260501064247.2027688-1-edumazet@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 2 May 2026 10:22:06 -0700
X-Gm-Features: AVHnY4L76fhrJfXJkd1D6BOWRTJx4KdxOwHhYreGjEgXu0fFOu0Q1_XP70iJ-T0
Message-ID: <CANn89iKeHvxWPR1QGLNZ1ruP9jTLxEtucxcYU2s0CVUkDe1L3A@mail.gmail.com>
Subject: Re: [PATCH net-next] net/sched: taprio: prepare taprio_dump() for
 RTNL removal
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 63D934B307C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-283448-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Thu, Apr 30, 2026 at 11:42=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> We soon will no longer hold RTNL in qdisc dumps.
>
> Add READ_ONCE()/WRITE_ONCE() annotations.
>
> Note: taprio already uses RCU to protect most of its fields.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

I think sashiko feedback is a bit wrong.

<quote>
Should the reads of q->flags in taprio_dump() also be annotated, given
that the write side in taprio_change() is now using WRITE_ONCE()?
The same expression reads q->flags twice:
if (q->flags && nla_put_u32(skb, TCA_TAPRIO_ATTR_FLAGS, q->flags))
and the earlier check in taprio_dump() also does a plain read:
if (!FULL_OFFLOAD_IS_ENABLED(q->flags) &&
nla_put_s32(skb, TCA_TAPRIO_ATTR_SCHED_CLOCKID, q->clockid))
Without an annotation, is the compiler free to reload q->flags between
the guard and the nla_put_u32() argument, so the guard could observe one
value while the emitted attribute reflects a different one once RTNL is
dropped from the dump path?

</quote>

My answer: q->flags can not be changed on a live taprio qdisc, it is
set once (and the logic is even visible in the patch diff)

<quote>
On a related note, q->clockid is read in taprio_dump() as:
nla_put_s32(skb, TCA_TAPRIO_ATTR_SCHED_CLOCKID, q->clockid)
and written plainly in taprio_parse_clockid() (q->clockid =3D clockid;)
and in taprio_init() (q->clockid =3D -1;).
Is q->clockid intentionally left out of this preparation, or should it
get READ_ONCE()/WRITE_ONCE() treatment along with q->flags and
q->txtime_delay? If it is intentional, would a note in the commit
message help explain why clockid is exempt?
</quote>

Same answer.  q->clockid can not change on a live taprio qdisc.

