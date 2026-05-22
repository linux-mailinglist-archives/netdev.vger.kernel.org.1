Return-Path: <netdev+bounces-290890-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNp4O4+PEGqIZgYAu9opvQ
	(envelope-from <netdev+bounces-290890-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 19:17:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92ECB5B80EA
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 19:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A5DDE300CE8C
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 17:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2EC1357CFF;
	Fri, 22 May 2026 17:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5IlDXJk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCC73563E8;
	Fri, 22 May 2026 17:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779470172; cv=none; b=kHREigv7ltZtqTf1q0vNcEgSshnPcPBGD2I4HKfQ3Wmkq5/sNPeVk0HbgGA7Pirx0rlKt+hBpIIUe+zxZltz/IuZaMgM6yZtdWrnB4zwjIjRP5GP4uB/Qy6V+JKxGohKE+aRjV+T9sv85/C96/8gA8mfGF9OwGOy5MECfcP6oBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779470172; c=relaxed/simple;
	bh=7zuIagNO9CQs6+XKSfea4mVEde0AxdKz46kE2iVjUks=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mZvTRDiwqQXw4KjJorAJHIKBsY23O6Vs2hE/CqntPUHjvtzEsJ5h32D1llfwj1Ui5k1tWOhf8SIXoj3CPof7CtnGJMm51+y2lf43uDWMDMMFCGEOgtKVePqvLua87YGgBTjpd826tvuMLX2QW9cnMxl1MbXnmLejiA4+bjAALB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E5IlDXJk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A4541F000E9;
	Fri, 22 May 2026 17:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779470171;
	bh=z6QLuZNUqmNP1TFC2UOy0mu4kXtWEnNnABsYAZIDhPg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=E5IlDXJk/C2DeA6VJkPIWc5aOIgpYxcyn3uN36FL24MutRANkpFiWwSXAN/RPkzes
	 kiYPhxAbgwcSbY1mIS9Dhpzh8FPUwz5O93HVB/E5LaJwntWVKVCii2a8coPj5UA+W/
	 AE8eeF8+sYI8NBAL/JMK1fq5BJU10C+43EGXqxD2dZFuc+flz08NekeZTiwjyfOiBu
	 SHBLe2TpdMKvI4w6frBMYh1UMvKJTCS1OLHsNjwnaxmDzO6/RYuLVymeJh52lZrLmO
	 7FVz/GTUKrV/hWbK+mKzinQc3AgeK9Jq2Zm6bbW108qXi0GgCqlcAj5iVlFUnEm26W
	 Jh1AwcvvXS3Xg==
Date: Fri, 22 May 2026 10:16:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "illusion.wang" <illusion.wang@nebula-matrix.com>
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 corbet@lwn.net, horms@kernel.org, linux-doc@vger.kernel.org,
 pabeni@redhat.com, vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com,
 edumazet@google.com, enelsonmoore@gmail.com, skhan@linuxfoundation.org,
 hkallweit1@gmail.com, linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v15 net-next 05/11] net/nebula-matrix: add channel layer
Message-ID: <20260522101609.7c2adfad@kernel.org>
In-Reply-To: <20260520032950.4874-6-illusion.wang@nebula-matrix.com>
References: <20260520032950.4874-1-illusion.wang@nebula-matrix.com>
	<20260520032950.4874-6-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290890-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[nebula-matrix.com,vger.kernel.org,lunn.ch,lwn.net,kernel.org,redhat.com,linux.dev,google.com,gmail.com,linuxfoundation.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 92ECB5B80EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 20 May 2026 11:29:37 +0800 illusion.wang wrote:
> A channel management layer provides a structured approach to handle
> communication between different components and drivers. Here's a summary
> of its key functionalities:

In file included from ../include/linux/device.h:15,
                 from ../drivers/net/ethernet/nebula-matrix/nbl/nbl_channel=
/nbl_channel.c:6:
../drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c: In fun=
ction =E2=80=98nbl_chan_recv_msg=E2=80=99:
../drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c:502:38:=
 warning: format =E2=80=98%lu=E2=80=99 expects argument of type =E2=80=98lo=
ng unsigned int=E2=80=99, but argument 4 has type =E2=80=98unsigned int=E2=
=80=99 [-Wformat=3D]
  502 |                         dev_err(dev, "buf_len=3D%u exceeds external=
 buffer size=3D%lu\n",
      |                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~
../include/linux/dev_printk.h:110:30: note: in definition of macro =E2=80=
=98dev_printk_index_wrap=E2=80=99
  110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                  =
     \
      |                              ^~~
../include/linux/dev_printk.h:154:56: note: in expansion of macro =E2=80=98=
dev_fmt=E2=80=99
  154 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt)=
, ##__VA_ARGS__)
      |                                                        ^~~~~~~
../drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c:502:25:=
 note: in expansion of macro =E2=80=98dev_err=E2=80=99
  502 |                         dev_err(dev, "buf_len=3D%u exceeds external=
 buffer size=3D%lu\n",
      |                         ^~~~~~~
../drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c:502:81:=
 note: format string is defined here
  502 |                         dev_err(dev, "buf_len=3D%u exceeds external=
 buffer size=3D%lu\n",
      |                                                                    =
           ~~^
      |                                                                    =
             |
      |                                                                    =
             long unsigned int
      |                                                                    =
           %u
--=20
pw-bot: cr

