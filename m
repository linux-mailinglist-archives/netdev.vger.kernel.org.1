Return-Path: <netdev+bounces-280918-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPOpKhzY6mnAEgAAu9opvQ
	(envelope-from <netdev+bounces-280918-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 04:40:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0624C459087
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 04:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 524F53018D72
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 02:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D70A277C96;
	Fri, 24 Apr 2026 02:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ar+WVo12"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954C325F7A5
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 02:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776998407; cv=pass; b=VAHK7zclg96BcXVUfQPeLgtI0CjsVZF5OJglRfJQHEGBJ9bcu676U/gM0IRn2AXvWSr4+U4sTYT/0V1TOedk+RrFALq9KrY1qp9txBua90A8UP82iGJsQoUHdQXEH3I7qC62ogspm5qYNaSewpk7fHFIqZt+gg7jioO2ltAmClg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776998407; c=relaxed/simple;
	bh=ncQrS+AzLmUOPluS5pHJNbUBX63csa/EN+EfVF6+O8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ffEC0Zld6i1o6ncV6hOB/nD6HZN4cAg6424TpY2gGsvzMxbw7eOlgtqXmtoZVjtF5UMhhqmLRNbfdqyM6H5jW+bv5dILeEawe1tVzrqylemVBJcTsx9dm40+hNOkmF8L8NhtDX1+h2qw5LX9foMVUvtDBSkwF1ZvTvHk1hN5EYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ar+WVo12; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-59e4a04f059so8693581e87.2
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 19:40:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776998405; cv=none;
        d=google.com; s=arc-20240605;
        b=JOI56KgcVEEEyqVRKTE1Rn6o4uizY6b9fiiDbB0UQzKQZr2M3IvIrgByODx9ZhQ1fv
         ddIZr6CsAnvIxpP70Sqhv0GAlnYVFLcrHZNOVaY2jd4HdNAQtOiA6l4a/5y0Pxj3gq+h
         S0KTjSQz9QQ2iodyv3Bcp3wpzCXrk96dmdmIy4tAZccBM30ARGrRKln4O1aVhKksMtU1
         yh44Qty0FIBE/4tFUpfpDz/oNobbBEKEbnvbCRvviw+TaipEMFbON0McD1SgV756x1wE
         olQCwikRHYh7bJQxVMEjcORhX2uMiwW0zACpTPpavm9/wPNzPxeWhIGQVZS8AefxJqPb
         bhqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ncQrS+AzLmUOPluS5pHJNbUBX63csa/EN+EfVF6+O8s=;
        fh=JNYGIOjvlqAWUXCoaVptU0A5i6vfTCP+Q0GJ2PIHBO8=;
        b=XbRToQtZH/0CoIPy62ll4iljSzdBMbSphCuPRRxG46AZ6s+rRFmevPibfbk5X6ObAF
         6RuoHoz07aL2eCT9kwiphpGGPdqX9cwN7bMexfFewuMxvTtUR7yF7JPanu8IAXvJYA4p
         H6oAp6ZMa8GSQJAUPX/nZ9bzK1L4oumZSf85SJ1kyVHY7MyvVTTEnfmlQ4fr1bk2Kewv
         oZvShVUnVpatSlYSQNxW7ehfYUdVo+sW6BThoqGKWIh8YVCdM7Korf92IJYodRmWihBl
         ntVbT5uTGuguwXtX8b+nr6aCZJDSTdLpK8SdRpgNnyTPMwtBqhyvobtCw0Es5qCrpaZU
         U44w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776998405; x=1777603205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ncQrS+AzLmUOPluS5pHJNbUBX63csa/EN+EfVF6+O8s=;
        b=ar+WVo12K+O4eJXHSNXL9uKCkxMhEQrgPnwWxg44NPIhu3b1n7aBkCZkcWPTeG5+9t
         SgoAuExonWSNldbcZT8eCgx7Cf4PTWkc9aRLjp5NHfxJHDm2rtHCpHZdSudOyM4XfahZ
         00PmdWI+sWA7ghNL5XKpYlweKdw4u5a3BL3CiRMHCi7Mxge+L2Ba6qaQVecR0ND22IH/
         0JPAETXMwPDVp8ZjOs6vK3C08wYpMIHtZXzvRUZG0Srg6i9NDN10FjrYEkQuzqJG+vfg
         nklXhgxFYdmFmFuNssO0ucWucFh6GpqJ3A2vXLnizrYgE4kshyOE9TsLckNqUISXfR6U
         0rkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776998405; x=1777603205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ncQrS+AzLmUOPluS5pHJNbUBX63csa/EN+EfVF6+O8s=;
        b=Ya1i5UGYoUFKLMeiZeX9JVvjWYnyNowkffPHidojJq5mUfeOqLI/hBTlf5BeZq4B7+
         o64QkEZp4ReTxe0cLUA6xdZnCncgYrapW/gWJnTtZpeX/1t5AA5ujgs9ugHlYLIJmYlu
         0m0yWYt+mZiUEdpBQJYIiyH6UAuS2cX+/8LPVBxIYLvjlqWfcjVTKBva8zSf85tWEggS
         yNo3tn3Fkov455wZBr6AU/GIwvXW7oFG0LlvHLz3RpUXhL+pOC+QY2joXH+GlcUUvNgq
         tlTFsqMR99BFGX59mmv0PJmXsV5F83XdMSBqWJjpS9tWTYuSLh1vby0wnwGmeUKHhZua
         /Ggw==
X-Forwarded-Encrypted: i=1; AFNElJ/F/gFeg2MspzE5vqzpjDrQNOq+1v5uqm2f85pUp8uDxlHjXULdUkpu49GCF2ka0Zt27T/Lezg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqOdDmZZVuYmXPzUer+STaHuVMPePozsunqSOSwifNwXvhHJcX
	85Tckp0NpgADvPzJxDrGhPezvf82/lvO5DCLBrn6GC0Q2KZw/cCb0R7MCluBOC6HjDPtzb/rT+v
	BI5U2+hGZCu7HpO/n7M7yG/dIzh5uNlI=
X-Gm-Gg: AeBDieuAjXb+ZS6rTd7JTfy1MPPzbWnxMUwjVReZfSBDOpYUtlU4RcO2AUoVOrZLhlc
	yhKJUGbopbxr+CSlkotDw8213wTyIeTQ3hP+7EKTQ7GTNK3c2dtTAmV7Xuvql1NCyXhGSn1jPfB
	u6+S+g8aLuwGVrRpTXFm42B09rE2mQMiTRcMe2ljFQfL2PtjKDWQmQr3bD/Frh2lOVEVtJmPK7Z
	JA3D2uh1TGuFYai1atnaxymRg/v/7mIpmmONuiXvZ7eBTk8QDZfnGtGObifIVldJ3RNvBaFC488
	9lxrr7gt2Q1edxW+isgCLLMwqTm4yCgooSz8hC0F3r30J4mMXa8=
X-Received: by 2002:a05:6512:b99:b0:5a3:cc81:efdb with SMTP id
 2adb3069b0e04-5a4172de867mr9140040e87.21.1776998404445; Thu, 23 Apr 2026
 19:40:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260423235422.1541768-1-kuba@kernel.org> <7ia4se8lb0vf.fsf@castle.c.googlers.com>
In-Reply-To: <7ia4se8lb0vf.fsf@castle.c.googlers.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 24 Apr 2026 10:39:25 +0800
X-Gm-Features: AQROBzAvx4d7CcF8GXaCg13ddTQn2ODtR3RVqyAvkaqKxwx7HWCG97wDtc16dus
Message-ID: <CAL+tcoA7RF2LDbOUaFz-06+w=azpizTMTi0E8v_geE2TWCSArA@mail.gmail.com>
Subject: Re: [GIT PULL] Networking deletions for 7.1
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 0624C459087
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-280918-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,mail.gmail.com:mid,linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Fri, Apr 24, 2026 at 9:31=E2=80=AFAM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
>
> 2c on Sashiko:
>
> 1) I'm working on an infrastructure to separate pre-existing issues from
> new issues. My current thinking is to stop reporting these issues with
> reviews of new patches and instead put them into some database and give
> maintainers access to it. Sashiko will automatically deduplicate issues
> and index them by the source file/subsystem. Hopefully it will mean that
> maintainers will see only a limited number of issues in source files
> they support. But I have yet to see how it works in practice.
>
> But I'm somewhat concerned that this way many of these issues will
> remain there forever and by reporting them with new material we actually
> have better chances to get them fixes. Maybe it should be configurable
> per-subsystem. I'm very open for ideas here.

I reckon reporting pre-existing bugs is very meaningful, especially
for maintainers/reviewers/key developers who are trying so hard to
improve this area. But it's a burden for a one-time developer to
understand and fix those pre-existing buggy behavior.

Syzbot has its standalone place for people who are willing to keep
track of known reports: https://syzkaller.appspot.com/upstream/s/net.
Maybe we could do something quite similar?

Thanks,
Jason

>
> 2) Re false positives vs finding more bugs I had the same experience.
> It's easy to tweak it to be more conservative or creative, but it comes
> at a price. It seems like the real answer is simple a better model. We
> saw a big improvement internally switching from Gemini Pro 3.0 to 3.1.
>
> Thanks
>

