Return-Path: <netdev+bounces-251905-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNgEC1TkcGk+awAAu9opvQ
	(envelope-from <netdev+bounces-251905-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 15:36:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1F958824
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 15:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E46B956DFB8
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 14:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF3748BD2E;
	Wed, 21 Jan 2026 14:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UBHX4/wP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB30309EF0
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 14:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769004205; cv=pass; b=rYJ9ItuCdnBWb/cR0hcAHhq4RPKx/3te6yH6RqtbnXzMK2lW4zDlxS+Y0X8qJJYEP5UULT1tX/jBkkJlGsOSS61+jCM372FY4Me/hjzaB5ROgwMWrHp0Ns19b7mqnCKAtQtXfEfKaArgLL2HH3aUOLrurGDhdZcR0GDkyfDwhSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769004205; c=relaxed/simple;
	bh=pVJAlnTPLe7ZRidQC24R/2MJx55kaJqY6OlfkH+uFZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=opZX5PYalivtMa3BZx5YzXcr9OmFMa2bTso62v5TNNJ3vzryuYfcLtClgpZxuzU32Xy6FNAJQyG66klQr1ueIwLjuWZp/f6LVZiAuqa7raBLXX/5OkLYFEiMT+VuH/MC0MMbeloauZw6unodyX7qAHnuOMxFEmbZA1PHrDGFcl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UBHX4/wP; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5014b7de222so67115481cf.0
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 06:03:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769004203; cv=none;
        d=google.com; s=arc-20240605;
        b=CeNqLG4/4xfZ4zs9cpiT/WXdGqjtyodWRHZ5whEXeY/BpI40FONxCRHyK+oLetVakG
         qzXJii427Cjdy8ihw8tZ+9SNrfC19jf8Oqypd1rxx0fVkoCOPLKSBoiYCzt0l2hDvSvm
         WHw72/3MjlN5ULXTfVPvI0BLZAQhPnyGoCU3KpvJSVYozlRQhN4QIKcTthVrHhgfwdVR
         Ys5ROpxMawYN1KrtZ+EAnINeCnAlEsGudi6jn0HLch0HAD90FXWMeqqtZuwYk33Dt5dr
         4OULj/A3F7gGMBvN82T96WaqJ3KDvGS/Rp1diRmnpkISDtcPlt6I5UKje2oL8/N3vvpj
         GhEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1xQ02uxLunjasR7mlrXJD6HDz/zpqHD9iVNJpMIrXJs=;
        fh=IpzcrSmtkeKabWHPYZDrW9m2DQN4Y9K54CPvV9TpZ90=;
        b=G3TekfKy0gRyMpDl3wE9+L8vZIpsvAll77OvJt9MNFyMM5tIU3at3OvxiNUUANwj+E
         QpNyK7IwgDMz4cbknOu8bcQUo/vjG/S9xb/Z82o5E92v8jqiQ+VZy+8lms0z6EnQAXVv
         lcH9WbVzGndW+tDux5om1l/lWlarxqY7ve848tAB/G6n8uiSxGcmI+gCLliQ55ksyxDY
         /YRL36pacPTCfroiGsXNzOfnDC0PjQXKwFqJzNC2kGK2KLi2aetrHmVfLqfnE4I5TB5w
         RCBBjL+sxmabLbsfzRrJrX9pCbBFTJPk1c8Y52lbCMkPSAjtltk/rfe9GGhF8CV29JmD
         NjXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769004203; x=1769609003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1xQ02uxLunjasR7mlrXJD6HDz/zpqHD9iVNJpMIrXJs=;
        b=UBHX4/wPtYAMgHqPG8vpWxOipbuLWlNOPVkEp7+09EpKjXVrxxXxhhedYDuLsihIq4
         +5Dm1gFcwvzK8T+sk04H7kCua6eUX1QG/xwRhCpdQRpZpr+fGcnNVoTW+LYjwB4czhgK
         LmGAMWyCZ9VjRM9JZPmLyiy46Vgi78uHQ7REOtJGB0Ou+R2mS65g2JVLwDtmoTaPWxLo
         GVR0BV+g5zw76h8pBpKXnk0L6/wLDBdNy2NSjLMF7vswthYWVU3UHfydbUiMR0HPiQb8
         t2aqJD14s70XpA0nsih8HLWuPhnELEj39AcJ4Hx8J3hvhMk8+8208NdiFirwMKoYkTA/
         JtMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769004203; x=1769609003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1xQ02uxLunjasR7mlrXJD6HDz/zpqHD9iVNJpMIrXJs=;
        b=tIXpIxNncOeiVhsjR9HVMgx3twMMpPkArqmoHnEGkt43yyvB2yaWljW8zTopBhE/7P
         bGjSb2Z60WKUuu9OO0hD89zYipgCTJmzXpxP9XP+/LmCET0H84IueNHJu+rzUS1oi/5t
         Qic0L0150UUiPJ32kZTwoL7/nRf1UfBHQMZb8zC1VKAfVRHda7LcBZl57QHkSqZzINLs
         IA7goioptYbFCud/bNgSuhJxZ0riqUkQbxGQl4cEfs2+wLLMVQ+RZCGv4LRulBQQ9yyY
         uQk7NJ0f3+BG+Tcgl+okkd8AKOD6A+cgLoTVINEsgfHxfjJQRmGdBK8EQjxEjnMzZDkA
         2naA==
X-Gm-Message-State: AOJu0Yy40Q+jkQFDer1HIzTEPUQq2+eUjqiAM0rjtCy9QFQqnCnfO5jq
	QESvRfZy56D1D1WxvvSixp59g4EvSU3Gapz2A7bBOqoqMJahGU4MWn5oIzBqXzht4HND3Ysl2Av
	qYhvzZ5mfg0mVLy9B6kIg6WIgsiNuRfoQu4rbRit3
X-Gm-Gg: AZuq6aIhwjRE9mFc99iltJqgXOAxS5tiFAu6NYHqZZpS40CFsAk9knX0rCPuTAg3Rgh
	1SLjIPsFdojLqO6Y63GWNux+jSQ8atiZJgqFsCMfdnlWrhFXqmgEQNgDGtdfdyOQqwrw/vHSEBk
	2MQzCe39Ic8ivZcMk9/ohnQxID9jNN+5nKVLHijNzIS+y1efuMG+iwt3thG9QuUVvhMETwUdaHi
	0rgx8keG5vOmSqGftov3/6ehTLVfCeZG9WlKJMZ74rQ+7JBvl0538nI1MM+5Do7zTjnIHw=
X-Received: by 2002:a05:622a:19a0:b0:4ee:17b0:6261 with SMTP id
 d75a77b69052e-502a168e7a9mr262497571cf.29.1769004202263; Wed, 21 Jan 2026
 06:03:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121131954.2710459-1-p@1g4.org> <20260121131954.2710459-2-p@1g4.org>
 <CANn89i+8_ZDxVGwQmo_44iCRs5Wexwxy1Wfhw4WmYg3qA7_t1A@mail.gmail.com>
 <BSn2a6IWtM_DnDrcd-qDBm8cXAwXPo3xj1l4Eu4SWy3BS2UW8Aw7-gXW6uo_DaCipnvmSxgDeGEQrnZ-pjqRKSOPPUW0usVN8M1lp1J-soM=@1g4.org>
 <CANn89iK_VqOThsWX2b-JwvF8suBVmKEmMm9D9SeZJBamDwfPog@mail.gmail.com> <YAOV0f1EtmF5tiEGoQMdsnQAKJSrqcg3h9hqnxDdba8MmAprjNHfcDBKselH1vYNZLb672n_zDJZpgjkVn0nHDS0Jh7BKQrh0uGwJYp2hEk=@1g4.org>
In-Reply-To: <YAOV0f1EtmF5tiEGoQMdsnQAKJSrqcg3h9hqnxDdba8MmAprjNHfcDBKselH1vYNZLb672n_zDJZpgjkVn0nHDS0Jh7BKQrh0uGwJYp2hEk=@1g4.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 21 Jan 2026 15:03:10 +0100
X-Gm-Features: AZwV_QjJ94otoWXwSoIy5yodC7nHjDCSaaJ1OxKnCSNDwziFa-9aPyMAIDoo6e8
Message-ID: <CANn89i+zuXMZ1Jx226rPG0nHKmRjL1s-m56xk-KD6nWLdrY1Gg@mail.gmail.com>
Subject: Re: [PATCH net v3 1/7] net/sched: act_gate: zero-initialize netlink
 dump struct
To: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mojatatu.com,gmail.com,resnulli.us,davemloft.net,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-251905-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	DKIM_TRACE(0.00)[google.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,cppreference.com:url,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,1g4.org:email]
X-Rspamd-Queue-Id: AA1F958824
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 3:01=E2=80=AFPM Paul Moses <p@1g4.org> wrote:
>
> padding? why does fzero-init-padding-bits exist?
>

Which padding are you referring to?

$ pahole -C tc_gate --hex  net/sched/act_gate.o
struct tc_gate {
__u32                      index;                /*     0   0x4 */
__u32                      capab;                /*   0x4   0x4 */
int                        action;               /*   0x8   0x4 */
int                        refcnt;               /*   0xc   0x4 */
int                        bindcnt;              /*  0x10   0x4 */

/* size: 20, cachelines: 1, members: 5 */
/* last cacheline: 20 bytes */
};

I see no padding.

>
>
>
> On Wednesday, January 21st, 2026 at 7:48 AM, Eric Dumazet <edumazet@googl=
e.com> wrote:
>
> >
> >
> > On Wed, Jan 21, 2026 at 2:39=E2=80=AFPM Paul Moses p@1g4.org wrote:
> >
> > > Yes, it's not proven so you might be right, I knew it was 4 bytes at =
best. We can do next or toss it, I don't feel strongly either way.
> >
> >
> > These bytes are cleared by C compilers.
> >
> > https://en.cppreference.com/w/c/language/struct_initialization.html
> >
> > Only holes might be left uninitialized.
> >
> > > On Wednesday, January 21st, 2026 at 7:25 AM, Eric Dumazet edumazet@go=
ogle.com wrote:
> > >
> > > > On Wed, Jan 21, 2026 at 2:20=E2=80=AFPM Paul Moses p@1g4.org wrote:
> > > >
> > > > > Zero-initialize the dump struct before selective assignment to av=
oid
> > > > > leaking stack padding in netlink replies. This matches other acti=
ons
> > > > > (e.g. act_connmark) that zero-init their dump structs.
> > > > >
> > > > > Fixes: a51c328df310 ("net: qos: introduce a gate control flow act=
ion")
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Paul Moses p@1g4.org
> > > > > ---
> > > >
> > > > I do not see a bug to fix, current code is fine.
> > > >
> > > > act_connmark problem was that "struct tc_connmark" had a 16bit hole=
.
> > > >
> > > > No such issue for struct tc_gate.

