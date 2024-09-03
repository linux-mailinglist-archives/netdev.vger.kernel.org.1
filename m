Return-Path: <netdev+bounces-124536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B005969E6A
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 14:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 209231C2323E
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 12:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068D71CA6BD;
	Tue,  3 Sep 2024 12:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qIWLsN5H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C991CA6BA
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 12:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725368046; cv=none; b=TSECHt4f8e5nyKChukL1eFP5pJPXTLN+kUJpDuYoY/0neWjj1aKjtfoUBuZeVMk5c16VNTfSYEIx3Cy7TynKfLZyCqgRe9pYOsVPkj58igVA5fXxjNQLezgbahxBl7Fs9BoBFEbzfVaS05G4mW/QRTksq2/j65eOwvMec7hwrBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725368046; c=relaxed/simple;
	bh=MyPVYGH7cfETXj7R2HVnqJyLS0AT2096Lb5YI3l2hwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iG7BbmeNJuKHoJUTlyQoSXkr6rO1xlKPy584AOpjdzURyo7LZERFvd2oE9BXRroJ6ue/3EPrZxxdq30L68ojn+Uu0JEgzlo2BMabvArvK70qK/Kp4Zgi+jzNdRop68O4P/xqtRRmphtudBNGOA5J4EAYEB+EhBDBbXCixq/zKfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qIWLsN5H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0412FC4CEC4;
	Tue,  3 Sep 2024 12:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725368046;
	bh=MyPVYGH7cfETXj7R2HVnqJyLS0AT2096Lb5YI3l2hwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qIWLsN5HXM5licvHfbOS5H94cdr8qPoKxRNqcaDWy7ObJgmWa/sEB1lOL2Bo26SNS
	 w8u6Y+Qam3P74UI01EjK+t/iwx+a164gtgYHWCfGZwqCkliaNMTi99jnHTld/YXepI
	 WYGlm4JZoVRamVVqL7r8qRbf5Jg1GxUqfIkPmjXLw77xYaRodNEGcCnf13mB1bf29U
	 EBuB4AbqN19MZssfTF+/uyoJvUVcqSzSl197ZdBiX4joFSkwcAFtuaHXaDTb/fLUL0
	 ya+zji+zOhQoXSoT7rDRqueH6VWrRWQ0DYi/T/PSuDkZdwUSruEctrdb/cnvnlaL2f
	 7y5xXez+9byFQ==
Date: Tue, 3 Sep 2024 13:54:01 +0100
From: Simon Horman <horms@kernel.org>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
	andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, kernel-team@meta.com, sanmanpradhan@meta.com,
	sdf@fomichev.me, jdamato@fastly.com
Subject: Re: [PATCH net-next v3 1/2] eth: fbnic: Add ethtool support for fbnic
Message-ID: <20240903125401.GB1833@kernel.org>
References: <20240902173907.925023-1-mohsin.bashr@gmail.com>
 <20240902173907.925023-2-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902173907.925023-2-mohsin.bashr@gmail.com>

On Mon, Sep 02, 2024 at 10:39:06AM -0700, Mohsin Bashir wrote:
> Add ethtool ops support and enable 'get_drvinfo' for fbnic. The driver
> provides firmware version information while the driver name and bus
> information is provided by ethtool_get_drvinfo().
> 
> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


