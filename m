Return-Path: <netdev+bounces-277279-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLJAM8in2GkhgggAu9opvQ
	(envelope-from <netdev+bounces-277279-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 09:33:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F643D35EA
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 09:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95DDE300D457
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 07:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1929E39DBFB;
	Fri, 10 Apr 2026 07:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Frfetgk7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BCB38945D
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 07:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775806217; cv=pass; b=q6swvFOEBu2ayVoJ46/RuaXWvILoywy7Y1V3jrDtJviLl/0IDosLP36KaH2b22hdqmxVgT09vlYCMGltyrlmjJfVNw5mDxXwwJkJhYKjvrAuIf5amrJBrb3BCKeg2wq9m6wRip9iURs0TbhTBzGaD3rKOZAEcsrAcWLtLL0fET8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775806217; c=relaxed/simple;
	bh=a3xqgtIrKXYucouRT8ax48kbL/eOCrfEpupSBLWRiWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iiAS+SgvhiqONw9ROxnvR0rCRlQzDBfrT1ed0bXn6uGERmjGyJuDDmhNYZh519lOCFdDa9S6fozNetKECAHwcKJoAH99XC7qmISpVaeQ83SH/HS3shnJz30dgbzQY3wiUTS4Pw8kSV1lDyCm1zCb2k048KfObXM8BHIZhQmnSU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Frfetgk7; arc=pass smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8cbb6d5f780so145106485a.1
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 00:30:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775806214; cv=none;
        d=google.com; s=arc-20240605;
        b=HVfCc4avQa1EKhtkiS+BFJ6fL9BBnTa10QlM4DPe0kwLNs9Q59kamZkKexC5R3ReJU
         v4l6x70WGpsEEV3JieHHTznETA5dy9kAK+7974+Adzv7LD6E+Y37LU7abrmRUEhhFM9e
         kBaFxU0FOpHPdf3pp0YdBSeBVAD/alw1SO3LhRVzgao6nHFAJ3NDDoXA04kd+Ms9KXGv
         ZB2E5n9eWii5lEemiVGOXG2itcumbLzm3U+MEQ/VMZxnQSBc1n+8K645avIcA6+AKm+t
         Cp7dOt5yal1mnum4iortl43m8VM6lcvk+VdLbn8G0NfRrwHdazBdePqsXZcrPffmHQ4f
         ld3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O7CX0HA3TT/mJRq93qFOrx+B4U/bcmkeVlHUTSz9a7c=;
        fh=maKaJRfjso9amBrfS7ZHuz+ad2Wd3cm0ZGDynkmR+gc=;
        b=fGatziIUIemPyCLnqofFGN4Tb8nxfnKnMaxG5H3xZkJSO3+kMITyuZCxJMPdIEIZpN
         IK86vDvoY5JCmdUhXd9sLGiscE8cwLDCOyr3tIf2gTrqNY5SbcNRtdrXAinXVQge6k6D
         B8Z1g7aplWiXiJUH6c02Q0ggDdi7TBoUS0L634Sm/9PfbL4ytTQN979/UGL4E9wxEyR+
         /vwlg1AmNdh8japwJlHpPutdnhhG6bciH8mUOf/ncxXzB50oK3g8cxmEsm1i0/bz6Puj
         b50ZcZTUMFvLew/5zHvl4533RIrVkXIoZtCxiejyc8CXQC/wDWziCl/95hB7YYe512qJ
         WWzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775806214; x=1776411014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O7CX0HA3TT/mJRq93qFOrx+B4U/bcmkeVlHUTSz9a7c=;
        b=Frfetgk7NQoFg/t8zro4DxcRnLbB7/2FO84GfPttwW7Ii2toyUlbJPD1K8ihL+N6Y6
         5y5HGGRhi73Ny67jl3NackevRgwGh/05GCrt3xE/9oJZ7HFlpDzVAkq6gx7rTDi7Ny78
         8kVZG20VAdhexdKx6/fL4MfaTKDfkYyQsowIUE38T1AnfH+liNU7uFo3h+UFHDnmIKFO
         sCgRRdPxrWRKusHUXimg13c85KdGCBCiarK3p2zL8ZVoUaHyw9TM5rEpQy5wxT9Nmgtz
         0Zgq3CJTIh7R1KgGPHQSLaX1C6vg08aAdLMVve0L1hNBMSuQal+bTe/RXpcRSCrNrI5f
         TXcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775806214; x=1776411014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O7CX0HA3TT/mJRq93qFOrx+B4U/bcmkeVlHUTSz9a7c=;
        b=ksIOxf7YWP6ybqSCD0eKslzFyvuOLnmgd3YxY46eA6GRUDsUZBTH8as1Pv/cdJAyQh
         fpb4zYhXGoMu6lr6ejGt76cMGC9brKhdTs08VT4AOY5cmzBrYdgmDzFVzAk895Jptfmr
         a3LiVZGSJwyfE34pDdtkk8ME8gez+48A479cZ7uLcxJkzhcWI3BGRc2g2vciKT098fsC
         ZcuZqdHgdr0eUyr3Bt2u24bs+chsZxGHGkfdLq8j27MqFNH2li+d1BupAzjuNajvuaok
         H1WZPnLuG81E+36qmGwTJLW//2ZsaFFfewcqgN728V/DbsVgjLNVEzaYaT9MwEMWW6fA
         PbvA==
X-Gm-Message-State: AOJu0YxgPTYxcSAYw9Oxf/AfvcMjYThKmRcYplFujF9O/I4mAOwgv7me
	zm5xXvY1/FmcAW0wMk0PsMaj61te9VNgpADABf5Pd5QIkaPFFi83U04C65lHbjbFEba4kpzD3m8
	aiGBCp+oPP3iVksH6OrI2f8gEZ0eSXfz6J7xXfjLP
X-Gm-Gg: AeBDiet6K8hcW5O1E4TYeFaNgeSUN1KoOXVq1cZ41wh8nY4CxV7Ub4iijp7vWsMt6B1
	iAX1N79vlQ8wL+C/r7OR5psIQcb6CVXNgUivCOi0NeCWkrvoo/gEf6uNvFTukJvI//6HbnG1bpa
	kEqxWXNcRRtHOt8n++tfwOJT981JXEzdPi8uFSVElxlsm4TRo9WqeDKOzkRlgj8NmQ5cWNjwwHN
	cv04YLYZdzxSXmKaADkymmFVicyFZTeiy0k8PLVaM4zz+DL+vV4hhH+LzPdClPKqIGHu0w5K3i1
	o7voyNLmFijpYt7LXPoJUjO01EuLgMXTyky3Zl006Y5wioPjyeS+DcRy3rhz8+1bpKcTAM8y8V8
	=
X-Received: by 2002:a05:622a:5c6:b0:50d:db76:55cd with SMTP id
 d75a77b69052e-50ddb765b27mr8045421cf.52.1775806213837; Fri, 10 Apr 2026
 00:30:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410034736.297900-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260410034736.297900-1-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 10 Apr 2026 00:30:02 -0700
X-Gm-Features: AQROBzB4wgMWGU5-oYXiKAU7KtvUfTOtg-x_AWVOekfm1Pq9_GhxdQiEzmrb_MQ
Message-ID: <CANn89iJg+35DQVw7zuGBqYhc8YhH1-g=WFs7XL7g1E8=HWi7Pw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: skb: clean up dead code after
 skb_kfree_head() simplification
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jason Xing <kerneljasonxing@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Michal Luczaj <mhal@rbox.co>, Mina Almasry <almasrymina@google.com>, 
	Eric Biggers <ebiggers@google.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277279-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,redhat.com,gmail.com,google.com,rbox.co];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 28F643D35EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 9, 2026 at 8:47=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:
>
> Since commit 0f42e3f4fe2a ("net: skb: fix cross-cache free of
> KFENCE-allocated skb head"), skb_kfree_head() always calls kfree()
> and no longer uses end_offset to distinguish between skb_small_head_cache
> and generic kmalloc caches.
>
> Clean up the leftovers:
>
> - Remove the unused end_offset parameter from skb_kfree_head() and
>   update all callers.
> - Remove the SKB_SMALL_HEAD_HEADROOM guard in __skb_unclone_keeptruesize(=
)
>   which was protecting the old skb_kfree_head() logic.
> - Update the SKB_SMALL_HEAD_CACHE_SIZE comment to reflect that the
>   non-power-of-2 sizing is no longer used for free-path disambiguation.
>
> No functional change.
>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks!

