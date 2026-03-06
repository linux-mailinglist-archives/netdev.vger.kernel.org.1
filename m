Return-Path: <netdev+bounces-264831-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHB7NBvqqmm8YAEAu9opvQ
	(envelope-from <netdev+bounces-264831-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 15:52:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF7B2231C7
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 15:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B27F300B85A
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 14:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92C83A4517;
	Fri,  6 Mar 2026 14:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TG4YPzf0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6052384231;
	Fri,  6 Mar 2026 14:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772808728; cv=none; b=Fs/I535tH5DFRf+JURduNbvPEBREWZURM1kH77Wtxs5Fo3LLmVwTYmcoGcB5sWvC8dP7kUI07leLcpHYb6Qbu9fWQ1ZtzAY74BaZf8+Zbx8VjjWg9JihcTD36RgkFZj6GYY/WnnBqCQVx85K53ooxL2Wnhx05M6q5Mq3uc+31uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772808728; c=relaxed/simple;
	bh=mJZyps38bx96mlFkI3hy/f1FLjlsYNxGo0dEudj4B8w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WFb80bcqb26LPYsVri4EPxJ9FVIhT3DDWKymVqeUnDRbL/X/oby8egevKpkW8GA6EMqyQCvtm2P3jvTHRnO28HKgUWLRivVWOmVy/TtMo2vX6qcRoDTBlBB55n/2Azr0ODO9MNoU+4lrtBczawMToPWHnlYlOdQAwma481TSFy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TG4YPzf0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58701C4CEF7;
	Fri,  6 Mar 2026 14:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772808728;
	bh=mJZyps38bx96mlFkI3hy/f1FLjlsYNxGo0dEudj4B8w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TG4YPzf0pLOq60S/LUcFNH4bFfkD3QA+/muUZgvyGICmFpO1zToWrFZPiMuNDzSa6
	 RsPS3I8etc6vMPe0ZS+UM7e916fzpe2M/bzc6SkYlB9aWMphFt4AwtfZsOvwMETVwr
	 xUgpSAo2/IF13dnH1KMRojyNBqyZc/FBja+yQmnaBg9U0kt8ZzwTSQ3lNBfw9uOICk
	 Mopk4kO4R+jdKh82ovGCPjRAI72LsJELzafPpxcTZThLf2tCBGwnIUuZMETG60W64c
	 VRXNpvSHGhBugt/+FPodU+tHGO2cOx0HcdGBilDQbeIjS0PVbn49Y+HOFG37p840vH
	 DXSK3oSlmkp5w==
Date: Fri, 6 Mar 2026 06:52:06 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "illusion.wang" <illusion.wang@nebula-matrix.com>
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 corbet@lwn.net, linux-doc@vger.kernel.org, lorenzo@kernel.org,
 pabeni@redhat.com, horms@kernel.org, vadim.fedorenko@linux.dev,
 lukas.bulwahn@redhat.com, edumazet@google.com, linux-kernel@vger.kernel.org
 (open list)
Subject: Re: [PATCH v6 net-next 00/11] nbl driver for Nebulamatrix NICs
Message-ID: <20260306065206.5ccc1927@kernel.org>
In-Reply-To: <20260306033451.5196-1-illusion.wang@nebula-matrix.com>
References: <20260306033451.5196-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 3EF7B2231C7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-264831-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri,  6 Mar 2026 11:34:35 +0800 illusion.wang wrote:
> This patch series represents the first phase. We plan to integrate it in
> two phases: the first phase covers mailbox and chip configuration,
> while the second phase involves net dev configuration.
> Together, they will provide basic PF-based Ethernet port transmission and
> reception capabilities.
>=20
> After that, we will consider other features, such as ethtool support,
> flow management, adminq messaging, VF support, debugfs support, etc.

drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c:29:16: error=
: assignment to =E2=80=98struct nbl_common_wq_mgt *=E2=80=99 from =E2=80=98=
int=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
   29 |         wq_mgt =3D kzalloc(sizeof(*wq_mgt), GFP_KERNEL);
      |                ^
--=20
pw-bot: cr

