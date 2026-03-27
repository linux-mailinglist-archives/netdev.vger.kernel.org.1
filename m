Return-Path: <netdev+bounces-272344-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMoXBL71xWkjEwUAu9opvQ
	(envelope-from <netdev+bounces-272344-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 04:13:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C63433EB2D
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 04:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD96C3077105
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 03:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406C0359A63;
	Fri, 27 Mar 2026 03:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2obhfDC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192EC34D4E9;
	Fri, 27 Mar 2026 03:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774580835; cv=none; b=TGzJsGL76uJmSq9B61/8DuI0MoGl9Lv+N1Q90st3seamhYjsGcWavVHXt1X1MihTIkGsx/DHOLw6uO/KRV/vGTGo/OWpwM8RSqMkpaz77oH7QMaKP4mnvL+mniAWQ0zu0wVm4nVrqVkjveIgc8FMFohxyUaKPp5tJIJDueTqyOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774580835; c=relaxed/simple;
	bh=bC1LrRM3t45yELHpfTwQZ5NHBJMwH07ZTkclwVOcNO8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mNQSNtcDS6Ls3CU2y7Iig5Z7Ii7EKBxzNdjsz15EJj4bvYZ1Bz522gOL+5kZxwpmA5wN61s7kDN9fY1x+UdAjfBWSaDETHGgoG/GwIYiP4bPmjSHm3Wrag+S3i/Z24W0Z024ban1SBTocM3L0797GSTWltZQIQzK76X66atIctU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2obhfDC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C693C19423;
	Fri, 27 Mar 2026 03:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774580834;
	bh=bC1LrRM3t45yELHpfTwQZ5NHBJMwH07ZTkclwVOcNO8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T2obhfDCTHyJdsqE0cdtLh8xbxIJO2NVs5bwsy+NDwk4KToXxqw9AxvUf3NpSy02J
	 qzBlX2CoOkHi632b41cYMc5Cno1NsBzsCIx46Ew/ARWAlS9XwMIxgJ4FnW7oT330pW
	 bJDrp6VB3FKYUu91wVYVwGVkCRt6ZZw1dbeubiJv7nfqOu2YqBbOTljdE6X5EN+AtG
	 1MD/W+odY78bEM7fUzEr+EDinOURgAJhvUK84fKCbak6FnhoLmiHFRYFnHMSIlPxQe
	 XEgY8kO2FR41FQqKc9WVsROHIE0Wn+DA4pTSFsAcptK9tffDDgoXoFSAtoEKNNILiM
	 lt2ovBrGptYfA==
Date: Thu, 26 Mar 2026 20:07:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, Omar
 Elghoul <oelghoul@linux.ibm.com>, Srikanth Aithal <sraithal@amd.com>, Jason
 Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio
 =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Vishwanath Seshagiri <vishs@meta.com>, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH net-next] virtio_net: sync RX buffer before reading the
 header
Message-ID: <20260326200711.7e7e048a@kernel.org>
In-Reply-To: <20260326180313-mutt-send-email-mst@kernel.org>
References: <f4caa9be9e5addae7851c012cab0a733be7f0974.1774365273.git.mst@redhat.com>
	<20260326181736.GV111839@horms.kernel.org>
	<20260326180313-mutt-send-email-mst@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272344-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,linux.ibm.com,amd.com,redhat.com,linux.alibaba.com,lunn.ch,davemloft.net,google.com,iogearbox.net,gmail.com,fomichev.me,meta.com,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8C63433EB2D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 26 Mar 2026 18:03:28 -0400 Michael S. Tsirkin wrote:
> > The hash for a patch with that subject in net-next appears to be 24fbd3967f3f.  
> 
> Thanks, will fix in the next version.

Don't worry, I'll correct when applying

