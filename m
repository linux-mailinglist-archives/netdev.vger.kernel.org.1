Return-Path: <netdev+bounces-271181-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHXDOnnCwmmjlQQAu9opvQ
	(envelope-from <netdev+bounces-271181-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:57:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CBA31980E
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E4348300B9DA
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D04539EF07;
	Tue, 24 Mar 2026 16:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+D5JO1P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C917A38BF6E
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 16:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774370639; cv=pass; b=N7KB51hd2FfDlXkMrx5qAfy8anMQXZJE9SRAI4kAlxrXISE7Hq76HADU6SvcIeKlVeFF8lsgHJwN1B31CVdLrRzjcFJEGeL573cCIrR1reUTvCBV6XhQyUE90glg4S2vImEKYw0z9TspIOd5A4OmKZO52NZM5Sq4GUfggSmiUg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774370639; c=relaxed/simple;
	bh=wMhn/VOSx8wQZ2wrgn2yL7x07tNOl524TUKw77uTWN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ilqGBmGLixHd0QQPqchtekp3vqT/qZWUE7XWP0d3p/fzZnOGwdNeWN5hRGCmvnX7ZxpMjMYGNtD2QlF8y5XTSx8TW19MYtQpH4aAyAgX63XLNwlNt1AL01gqt0rq8vAVdXPVOnLrHULucFJvbREA+5zyP3oPJvJGjRweMjro2RI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+D5JO1P; arc=pass smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d7f592b8beso3459830a34.1
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 09:43:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774370637; cv=none;
        d=google.com; s=arc-20240605;
        b=LpaOrvWFBDyzu2MeQKx0SHIB1dZo89DmJd72WhVDFi+YBYsa9rwgGYED1AY/hzh7nz
         bUM9l08xAN1aWCeQmB8qRBdIh2bFR+tH0hGMR93ry92ACAJYYUmv/LK80flX6+ioR5nz
         L2lmePw783WLNbZ1xHVBPBVXsA+GS023JucxC7snhDYCMYjwt0nb07kmF9FrNYZTLzVg
         gJbkc0yT0o5xTJOFZI05vNVSAsRH+BRoNf5N1wOA7BIZUZkPcMvBx91LjJGjA3wcuqAy
         6nZN1GRy2Nd4RWxKH6hlNmM4ea/a0uIHBIqGEbsRWDEMaCXinYwLApGR8+ERATHcVgE3
         sPFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VQNlVms+kpR1Fh0SxxqhqTFBARw92N1Fe984l7ZR91s=;
        fh=19tvSu9bbU41bPd4AxSYp9DzoSyf2n3wWGl7fyERknA=;
        b=QBGxun90/NBhO+DbwJUwtRzUdMoCDPlDn91UEZofD9E0J0oITohVixQfX4g+5C9crS
         sria9dKhTrmca6P1grG6giEY20w5ilTRt+b3+la5RTgjdPO7PtOGSAF53NhQnlQltZGU
         pg8SNk5oyCQhI0HOS1KrrE3snfEnrd/XjEPqR1zHtCtO/m+NChEiHtrEowPD0CjcbGaX
         rEMsvkt12qwYRMUPk29+SPxmF/h5WgQ/GX/jA4sRgIf68k+2X0d+vkaJL9lF/d35yHu3
         7HLxLtNyTzGsM4tRhbg7u3Qex7DqMQsw9eE4UyTHxzvd8of7xmgdZzuV5HO+r0yuSeHO
         zjvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774370637; x=1774975437; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VQNlVms+kpR1Fh0SxxqhqTFBARw92N1Fe984l7ZR91s=;
        b=S+D5JO1PbxYWXUiwXGyAXzxqf5X1G1pxt1dpz4c+F9zrl6Qj2nmJfA0Op/JMZOFaly
         o5rotKiY4AAf5TT2smTfXkk0OL731omu8DeGPSpoy0oh3l5zoF1mH5iOCDqfBhP68W+Q
         6MxtnR7Ae5IFsTzk95ErJx3Yvm1jGztQ9qq55W/x8BkKO8aeOOlDD0nP8MXWQ2PeD1vG
         zoEROuUbHKpg98ptLkyJxCseA0EPa/PlMU7MZNgB2poP+O23sywK7PK8AfnJ8yhXEIbq
         BOmFz8/GwevXCf/wzfbFo5AyGLZNjWoZCTQzIDD55YCTVXQXYaNLxpx+LVW5A/DtrnPM
         yO5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774370637; x=1774975437;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQNlVms+kpR1Fh0SxxqhqTFBARw92N1Fe984l7ZR91s=;
        b=a6z0g338fs8qDDD5mtfuO+RPVZcrCOHXP5nukejjNQJbcVQNiUlXCStM3WOayqUAGw
         NSdsd5ibRbBMOkf5HLMuMS5r7ADcyp1kVep+28lZEpGllLsVZFwhhyGYVmsUVyJcbSTX
         s+QiDF3WNUPCOK+Jmupy8VYOkPeYAHgTMet/pkqoLtgNzJDw5SkZViJ0HQ2LQr7dmwCC
         7BBbnyrddLnQr6RTgeJeYExabpQOOEE5xQvA2I3FSDCud2s3DvWzqrgh4MOGRza5ntM7
         FG2anBDWco11kF+0BjyYOceM9+pgpzUFXUbb4ljGdVMPmEc+1A2njXwHfFB79uQvrmOk
         YEUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvP3BrT3jQer8hpoorNLnTrLHc3SqeqWsXJCGadgMfhJZalEvrxubMt7GMgWSMCNOzFuCxlzw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkouy0fRJ/a5sJYHRS5jdt/T7xaAaBDECfNhSf2rbpnfQSJJqO
	+ig+xPPg6RiOhVAyUSt+LPafMxzELfg36+53Us4bRjizvJ0RRnd3eb5wZ5ooB9LGcxXIT43h7dL
	8jnoMGgZ3aqeSNlQoHjYgPLgV29XBpJE=
X-Gm-Gg: ATEYQzz9zXzkM+M48JN5WVryrBBnx3uFu0ExO13z4W3GiAmDxt5qfzyKgp5Nz86HYQe
	cd9ClUKqPGVbJRYRTIY/D/IxgQclP0sCn5w88qzoTAM96FcbEMFlewwd/Q2JORQgm1l9g6uV674
	KYBkN+YjsPweSCy5l8Rt2TzJTcvlI0sgqSrvswwoIvD9KkZ4/1MEn10UJS8M1vQu0ji/b0B185Q
	j31lNJUwjnKW/Axsruq9lMwpEqqZIzm8fNrmNOKNd4yVzSRcfChGRvTBOv/VFSs3Hqw4GLcq+NG
	x8WWGWXIgTaLRPM9S3pIHPJ+8Uc7TMw0Y4OSEA==
X-Received: by 2002:a05:6820:c8e:b0:67d:e7c3:3c65 with SMTP id
 006d021491bc7-67dff560547mr270405eaf.56.1774370636622; Tue, 24 Mar 2026
 09:43:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324163033.310087-1-devnexen@gmail.com> <acK9rdPQNqwejye9@strlen.de>
In-Reply-To: <acK9rdPQNqwejye9@strlen.de>
From: David CARLIER <devnexen@gmail.com>
Date: Tue, 24 Mar 2026 16:43:45 +0000
X-Gm-Features: AQROBzBf_N6RNh67NUUiIABLHoehABRSY8FMwhk63hGAMLH7UCEba6IjBCXwY6s
Message-ID: <CA+XhMqwEhxCcdpOvEdczwYsfZuAFuvN+oB2rzuL3Gtic3tpNPA@mail.gmail.com>
Subject: Re: [PATCH] netfilter: conntrack: clamp TCP window scale to
 TCP_MAX_WSCALE via ctnetlink
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Phil Sutter <phil@nwl.cc>, Eric Dumazet <edumazet@google.com>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271181-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F1CBA31980E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Ah well :D thanks for pointing out. Cheers.

On Tue, 24 Mar 2026 at 16:37, Florian Westphal <fw@strlen.de> wrote:
>
> David Carlier <devnexen@gmail.com> wrote:
> > The normal TCP option parsing path clamps td_scale to TCP_MAX_WSCALE
> > (14), but the ctnetlink path (nlattr_to_tcp) accepts any u8 value
> > (0-255). This td_scale is then used as a shift count for u32 values,
> > causing undefined behavior when >= 32.
> >
> > Use NLA_POLICY_MAX in the netlink policy to reject values exceeding
> > TCP_MAX_WSCALE at parse time, consistent with how commit f900e1d77ee0
> > ("netfilter: conntrack: add missing validation of SCTP netlink
> > attributes") addressed similar missing validations.
> >
> > Fixes: c8e2078cfe41 ("[NETFILTER]: ctnetlink: add support for internal tcp connection tracking flags handling")
> > Signed-off-by: David Carlier <devnexen@gmail.com>
> > ---
> >  net/netfilter/nf_conntrack_proto_tcp.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/netfilter/nf_conntrack_proto_tcp.c b/net/netfilter/nf_conntrack_proto_tcp.c
> > index 0c1d086e96cb..7d364337d71e 100644
> > --- a/net/netfilter/nf_conntrack_proto_tcp.c
> > +++ b/net/netfilter/nf_conntrack_proto_tcp.c
> > @@ -1386,8 +1386,8 @@ static int tcp_to_nlattr(struct sk_buff *skb, struct nlattr *nla,
> >
> >  static const struct nla_policy tcp_nla_policy[CTA_PROTOINFO_TCP_MAX+1] = {
> >       [CTA_PROTOINFO_TCP_STATE]           = { .type = NLA_U8 },
> > -     [CTA_PROTOINFO_TCP_WSCALE_ORIGINAL] = { .type = NLA_U8 },
> > -     [CTA_PROTOINFO_TCP_WSCALE_REPLY]    = { .type = NLA_U8 },
> > +     [CTA_PROTOINFO_TCP_WSCALE_ORIGINAL] = NLA_POLICY_MAX(NLA_U8, TCP_MAX_WSCALE),
> > +     [CTA_PROTOINFO_TCP_WSCALE_REPLY]    = NLA_POLICY_MAX(NLA_U8, TCP_MAX_WSCALE),
> >       [CTA_PROTOINFO_TCP_FLAGS_ORIGINAL]  = { .len = sizeof(struct nf_ct_tcp_flags) },
> >       [CTA_PROTOINFO_TCP_FLAGS_REPLY]     = { .len = sizeof(struct nf_ct_tcp_flags) },
>
> Makes sense, but I would prefer to update everything in one go, as in
> this pending patch:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git/commit/?h=testing&id=3b77a876d9b980daf27f0fd70eaa7344db7c36a7

