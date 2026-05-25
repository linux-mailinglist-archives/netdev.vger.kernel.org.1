Return-Path: <netdev+bounces-291421-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 9ctEArOZFGo0OwcAu9opvQ
	(envelope-from <netdev+bounces-291421-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 20:49:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 81EF75CDCBF
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 20:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59C5F3006798
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 18:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575F537B00F;
	Mon, 25 May 2026 18:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Udn7zL8H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E69D372054;
	Mon, 25 May 2026 18:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779734953; cv=none; b=usvXwlSkXrkL4TiNuEy65VVKp6HBsu2NR1e88OoL57QQ+zaCsJ4AHMMTDoAZtWjiL5jBIHaNw88m00Jlvp3/fXK6dwoVleMSd75T7KhJnLEEt7qptDzKWAh812K2t7xc9sOFvqdUyy6+6JcHYrxZU6HM4VCY11h2v9D2IGGfWqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779734953; c=relaxed/simple;
	bh=H72zRI8cP/KffugqxL7L36mJRek0Vxk/13r9uYCI66o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qzlPIaW+l/S7Q7rNgn3AmrOaIUsEE0xscNHAytHjVZX0h7LofbTu2MERM/3tBEzzMlpyUsrzN4yBZEdqoCjDXo7hsE36lrv8jA0fu59W4/nBFe0B9MmO+EJD4LOkwtSHa4DdDYDts8BQ9nqEtNXqEF9lrOTcJ2i7XcMctBPR5GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Udn7zL8H; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 863251F000E9;
	Mon, 25 May 2026 18:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779734951;
	bh=gayMRpTAXCPOoFKUyUtLNpFZ8RKzjHieHL0byLqgm6E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Udn7zL8Htl476+mo5A7cVaYMhE+iaRkAb14xIaxb6930Af2EnBLlq4FmuMGkMNqSN
	 Twn1s4xV9buYw+lE+/OfIs1whhSWBRZ7b2J16oK8KZgGcvsFnktitRAejQz7fySlOf
	 G+e7Piwy7pmy1L/FoVzNg35cNTbjtWSmLHZL1PtfexkCk3krlewoS/Q7tzgIAeCJYw
	 JdUGX5jIXvZaY51NaRfIU1DkecSJ0eijhe5Okk50SWDOp1AY51rCdwLBX4yIBp1jL8
	 3W/TWc6NxEu1kjvAvqPKMVhsgpqg8hgYV4T4yIIeK2OL/QCRWWxb6hgcHruy9Fw9GQ
	 P+Y36pZlWuwZQ==
Date: Mon, 25 May 2026 11:49:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Li Wang <liwang@kylinos.cn>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang
 <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio
 =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_net: drop redundant err assignment in
 virtnet_probe()
Message-ID: <20260525114910.47806c7b@kernel.org>
In-Reply-To: <20260520102309.281616-1-liwang@kylinos.cn>
References: <20260520102309.281616-1-liwang@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-291421-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 81EF75CDCBF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 20 May 2026 18:23:09 +0800 Li Wang wrote:
> err is initialized to -ENOMEM at the start of virtnet_probe(), and no
> code path between that and the devm_kzalloc() failure can change
> err. Assigning -ENOMEM again before goto free therefore is redundant.

This is asking for a bug, someone may add code before this 
if () overriding err to 0. They are 130 lines apart!

If you want to removing something remove the inline init at the start
of the function. But FTR I think that'd also be pointless churn.

