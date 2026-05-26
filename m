Return-Path: <netdev+bounces-291973-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDKNJw0rFmqdigcAu9opvQ
	(envelope-from <netdev+bounces-291973-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 01:21:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E4C5DD7E9
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 01:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9299B300CF08
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 23:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8883CDBA8;
	Tue, 26 May 2026 23:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wx5seO9x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0DA3C0628;
	Tue, 26 May 2026 23:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779837703; cv=none; b=qoNtiQwN5xTOQkUtMe6oEpRmf8vCuHDKGwPBqIN4CLJfbXJOCbAGkPBGOyY7oXIXrUMJSFYMmSwptO2815BVXfZwAdsbNLYZylCoEoTbSn/6Mr/V3hxtsiDIgQPrTvudn7PCfWaHYRXk31UKJyy0tqVaM0EPbVMJAfbwHYT+FL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779837703; c=relaxed/simple;
	bh=3JtiWl0vRydfWQsGBpovYwdHgc4CmQTwlFTcACuBDQg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q/hiVuONLHbsZ4ANFAJ/z9QpaSKkwXvmA2LEqxYJmRdI7K3rOrqZ2WVcWlGdnxmkYaT8mLMAH36U0Cy/G2iTdeMbYWX32ktJg95lmgppWm0XvepatGP8sBsaHk0mHhI5VnD3miK663Y13tdL5/huEPEW90bJfJwzomUdzC/7amg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wx5seO9x; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3FB51F000E9;
	Tue, 26 May 2026 23:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779837702;
	bh=yJt45ObCHCD/H8x09SxlAekMdKt4JVSvNjsARTZrmS4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Wx5seO9x3Qhd0dQn/I4XHEcajF6tFXKfoJbKbEQUAkSMioemkM8axOki4sSSCY+YP
	 wktrLa9DKl0uP9r3gBWXxdl9Rn88nWIkbWlbQnfAj00tg9AFN3lHvd38srCqvx0T6k
	 5gPSu/uF0Rm2Xk9H3GebR52z1Q+W7IzascSSiSpSmEb3UNGlz1MThc4Cq2ggAbE9ic
	 PWRXBwG2c5RKRAXGhaI+CF9M9LUmHMmifUthY13f89HfWE9L/gIMy/BUtcT2Y8X/W3
	 W4cmK/4EE0/5Ggqgde1Wn/TX1Ep+pvidq+PlCdxoGZS4Q7Aro66AN2JH5k6hAv3BVD
	 4HeYW6a2bl4rA==
Date: Tue, 26 May 2026 16:21:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "illusion.wang" <illusion.wang@nebula-matrix.com>
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 corbet@lwn.net, horms@kernel.org, linux-doc@vger.kernel.org,
 pabeni@redhat.com, vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com,
 edumazet@google.com, enelsonmoore@gmail.com, skhan@linuxfoundation.org,
 hkallweit1@gmail.com, linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v16 net-next 00/11] nbl driver for Nebulamatrix NICs
Message-ID: <20260526162140.38d055b4@kernel.org>
In-Reply-To: <20260526035453.2359-1-illusion.wang@nebula-matrix.com>
References: <20260526035453.2359-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291973-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A2E4C5DD7E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 26 May 2026 11:54:37 +0800 illusion.wang wrote:
> This patch series represents the first phase. We plan to integrate it in
> two phases: the first phase covers mailbox and chip configuration,
> while the second phase involves net dev configuration.
> Together, they will provide basic PF-based Ethernet port transmission and
> reception capabilities.
> 
> After that, we will consider other features, such as ethtool support,
> flow management, adminq messaging, VF support, debugfs support, etc.

The coccicheck bot flagged a new Coccinelle warning introduced by the
nebula-matrix driver series:

  drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c:187:45-52:
    WARNING: Consider using %pe to print PTR_ERR()

The scripts/coccinelle/misc/ptr_err.cocci rule fires when a PTR_ERR()
value is passed to a format string without using the %pe specifier,
which is the kernel-preferred way to print error pointers (it displays
both the numeric value and the symbolic name).

Please fix nbl_main.c line 187 to use %pe instead of passing the raw
PTR_ERR() value to %ld or similar.

For example, change something like:
  pr_err("...: %ld\n", PTR_ERR(ptr));
to:
  pr_err("...: %pe\n", ptr);

