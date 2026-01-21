Return-Path: <netdev+bounces-252037-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCmPNmMjcWl8eQAAu9opvQ
	(envelope-from <netdev+bounces-252037-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 20:05:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 305405BC8C
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 20:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 52A6E5C5C63
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 18:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAFD347BD9;
	Wed, 21 Jan 2026 18:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="YG5ejmNG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94945275844
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 18:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769021451; cv=pass; b=h201MgjnxwvBg6XVm5sRZl/CVINu34pYLsI9J9Re/YyLKYMkCAMDkdR1plkSbh83niv0qPl55Ddat4t1lZZjsXLH1d5U3V4Lfij+SPlcx4NFshzfRDAWN0/YrqgYY9Z+4Io4WGmrQPU1TmOCrpfi0HkY+QbYLvlxypi8kmP71Bc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769021451; c=relaxed/simple;
	bh=zaws6EmeMTGq5AKHGbFBsOId4T95J+FmRUAbPAZ/qpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q4M/mCJzhfuFJ5WI8FGZ0iu6nx+fCJhvRUEzkJWdw7Cg2rEzZZcL0FnGUAxwn89KCy/zCutefP0/OSd8sC25BQzYOPiYSUWnPGt8mZMK8DMpunGn9kkC88RPdlK4KByo06IidyaosJKgN4Mp2ZfSJuVMU3AYQg1PsQB0nosz4v8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=YG5ejmNG; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a07fac8aa1so1270535ad.1
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 10:50:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769021449; cv=none;
        d=google.com; s=arc-20240605;
        b=GMNGHXETAXZZc114hI1+t/3e0aoTV1s6ls5HkcUZCBC07fsOMA+UegYCJqvM+gBtRW
         UdpW9ltLbhYu8Oiongd6lJUwfU3Zjp5+ulDhxaR16dG5DVgmSXMN6QFwq+/sCllBkw75
         CN0wyXHvOt8EZbADEuF9Cw2Fo1QfpWKDHz04xMos0/sPHaCANAEbr8YqU0ayvzV/bYpo
         bpOl+URyhOGZX/I+cnz52La7KPyvu9VPBJ1zuZ111ZrQHjvO1EsY3zgKnaXCjkscW9bz
         4xPhMXNnmayTZ453qViSf6gRYKq720i+Xp8BmmtGSjwzjEuGDzQPcphVr9gKyiwZnpj/
         NGMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zaws6EmeMTGq5AKHGbFBsOId4T95J+FmRUAbPAZ/qpg=;
        fh=uSF1fWAiYiXb95F5Oten3m1ib0QPh2tpGvWeeaYhlv0=;
        b=KWdXOkI1x+hTib9gGsBDFLg7GsDCYkgICC1v6vBzD39f0U2qkcnOAY5qDahl/pJOTQ
         Uv9wiDQHR6lNh3JRMYthbNxK7PUmjWtFiPGfrz+vv/7cpRBv2JOiIWz/NOkEtwaG7o23
         4sAaVDOM07RwYiNfKIYyek4QlsJKFUcz3jaRgn78GauQT9BrOmAwh2uXqlV5n3QPbisZ
         oF+gGAAornfhS62B5JWs8dUSQSpxSewYUkTypGpSRHTnUt9Ebdjr3RoUfRD4ofDTPGzP
         Ip6QsY8fD9sv/+NFBX9lV/HMQjse03eyWpzka9jXsXQ9Z3LhnyRV501fmi1bqenjCQzN
         8ifw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1769021449; x=1769626249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zaws6EmeMTGq5AKHGbFBsOId4T95J+FmRUAbPAZ/qpg=;
        b=YG5ejmNGeG9uQD6os3S+5wncDKXjEwgiXeweIABBzCuoQvirKQDqqjjt5zZQzYkaN0
         wpwaigsoxI2593SXlljdT2qTPvUN+fl4PYFPNg/85BusR6zBRidsUWKDbkoSTfQuWzyV
         Gx9XGA/NCAgyrW2polw1AVK3hPID3eJylTyLcwG7KlLpYfr1BVoXeaSEjwmjwM+YsrgK
         KfyXHbMnv06VonWTGLiNfSjNajWZJ3to2t/EqeEevRjX88FQ7WfXRi20KxdTzM6jdVn8
         8blBDrqoDXEHkPLLGzZ5mh7fvEI14k4gxUpAXAGLh6VGOpQTkGi6vUiokOfZrUF+jg07
         137Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769021449; x=1769626249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zaws6EmeMTGq5AKHGbFBsOId4T95J+FmRUAbPAZ/qpg=;
        b=qKXZLKpaDxICy/Jvr0joO/V2OKvZ9X6AXAhPF8FA1NL21oEF9C2Sqo3vsmyboaJk/Q
         X+10AcwU5IiiNKgMkazbXAGqE2cZfP5qYmgOuEDno2XKGDVMoyHdQWqJps1Dvg/XMuMt
         HDGMwHGi+rUtpe49CCN3/dG+7OVpsrzjDZ/C5QidO0nnRVW/UG9mszyjxW4xJuACvptx
         THYsuKLVmHj0rqSK9xyEunID5SLD3YsBWVLsWAzCRh3aB94G3erMCybHpsJBWJBOhDL8
         b8ww2t2zYg7Z13fYfYnAMk524WNgXLA055+1OdPscwEV8d72oCbzZ/1eN5+Fg4abgEJL
         8sIw==
X-Forwarded-Encrypted: i=1; AJvYcCVFMWTq+/feO9y2Lv47Mqb9vgAH5b1Kuy0bWmVhd2dxDkHqVR6EIZ/55KM/DJzb63i/WPnJ97I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2UKprCDwmxLsNn8dksC3vjl1DP4QQxyZmzwdL4TyQaAfNagYH
	qfZIW3MpI20/vDvNchx2hzGjjEy0aJ1H5yWuOcEnl0N/wpsgzsflJTYbChED86INEmNnPMuAZXL
	Dxgj+c1PjFua4W2uYrqvCUvREY6vV75NS109tTmYcgx/w6zhhjRuPLA==
X-Gm-Gg: AZuq6aIN8jVYes9uEpNTTtuCSzdwR87luaIV117ISy+KHISXiUCx5jpa+HmLS6r/WLS
	k7KaQDioimo8hKJVFQnPvHeGjjJtvM+Pbp3a76oq/mA7cerA18PNm5IVwmAEhOiiN6utzIV1Mje
	2xkYUW8YxY6P5U/+pmGfP7QqSoz0iQxVxAubCXMF9VikZhJCrElNeuNrYkMP4VKm6TYjfRBNZpr
	2Mr7yQSoCaK9E/+6WM6gharlipA19mFWlv2MxO0uvS+eBiJ0rXAM8RzQ0lKbpvPikECai31pOX4
	MiY=
X-Received: by 2002:a17:902:db04:b0:2a0:bb05:df55 with SMTP id
 d9443c01a7336-2a76951f3a7mr54485465ad.21.1769021448764; Wed, 21 Jan 2026
 10:50:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260118061515.930322-1-xiyou.wangcong@gmail.com>
 <CAM0EoMn=bx-AMR0RbFmSj8MjWTxLtB_xo5419AW18paZ9r1wDQ@mail.gmail.com> <aXEIJEiRJb3hfP5n@horms.kernel.org>
In-Reply-To: <aXEIJEiRJb3hfP5n@horms.kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 21 Jan 2026 13:50:36 -0500
X-Gm-Features: AZwV_QiMLAgEMNblQvq8lLwPiE4VpwETVsvv5r1_OiEsuu2M3lwtxzU0HbM_h9k
Message-ID: <CAM0EoMno99TjydUogh13tnWks-o7crt6mz1g7X5hyVF9ASmmfw@mail.gmail.com>
Subject: Re: [Patch net v8 0/9] netem: Fix skb duplication logic and prevent
 infinite loops
To: Simon Horman <horms@kernel.org>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, David Miller <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Victor Nogueira <victor@mojatatu.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, William Liu <will@willsroot.io>, Savy <savy@syst3mfailure.io>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252037-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,redhat.com,resnulli.us,davemloft.net,google.com,mojatatu.com,lunn.ch,willsroot.io,syst3mfailure.io,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 305405BC8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 12:08=E2=80=AFPM Simon Horman <horms@kernel.org> wr=
ote:
>
> On Sun, Jan 18, 2026 at 10:07:37AM -0500, Jamal Hadi Salim wrote:
> > On Sun, Jan 18, 2026 at 1:16=E2=80=AFAM Cong Wang <xiyou.wangcong@gmail=
.com> wrote:
> > >
> > > This patchset fixes the infinite loops due to duplication in netem, t=
he
> > > real root cause of this problem is enqueuing to the root qdisc, which=
 is
> > > now changed to enqueuing to the same qdisc. This is more reasonable,
> > > more intuitive from users' perspective, less error-prone and more ele=
gant
> > > from kernel developers' perspective.
> > >
> > > Please see more details in patch 4/9 which contains two pages of deta=
iled
> > > explanation including why it is safe and better.
> > >
> > > This reverts the offending commits from William which clearly broke
> > > mq+netem use cases, as reported by two users.
> > >
> > > All the TC test cases pass with this patchset.
> > >
> >
> > These patches should not be considered for any review because they are
> > not following the rules that are set for the community. The rules,
> > which are well documented, state that you must cc all stakeholders.
> > When someone does this _on purpose_ such as Cong, some accountability
> > needs to be imposed. I would say totally ignoring these patches is one
> > option. Otherwise anyone can just throw a tantrum and decide those
> > rules dont apply to them. Either that or we modify the rules to state
> > it is ok to do this..
>
> I'd prefer if we applied Hanlon's razor here and attribute this to
> carelessness rather than mailce.
>

Making a mistake is one thing. I made a mistake by not Ccing Stephen
the other day. When I realized i hadnt, I immediately followed up,
sent him an apology, and pointed him to the thread.
This isn't the first time Cong has done this. So i dont believe this
was carelessness at all. See this thread:
https://lore.kernel.org/netdev/CAM_iQpUGvHLB2cZmdd=3D0a4KAW2+RALNH=3D_jZruE=
1sju2gBGTeA@mail.gmail.com/#t
He posted the patchset a few hours after i responded to him.

> Please let's find a way to move this forward

I am not going to review this patch as it stands right now. If Cong
wants to explain himself, I may reconsider (which does not imply i
will accept this patch).
If you apply this patch as is - then it is only fair we fix the rules
to show this as an example of where such rules can be ignored.

cheers,
jamal

