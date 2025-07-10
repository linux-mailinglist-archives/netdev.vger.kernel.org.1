Return-Path: <netdev+bounces-205817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DF2B00457
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 15:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22345188ACF1
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 13:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B672F2727E9;
	Thu, 10 Jul 2025 13:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QoRkk9ck"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996F027056B;
	Thu, 10 Jul 2025 13:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752155569; cv=none; b=KIP9O5Y2N7DHE1+5v21tvaAHHSwfS7DoRlN5SGA+O3COkXGbwhbrW4jjPvQA/kOpo5jaT57K/GmUHQPDsC5ysB16yBUPqTbxVoygsu4Rcc7weT9pg5uo02ovHrRXyCRw6km1AwOTG/9Hiead9YI1yCkvimFxmrSEEuZ3I0xXkKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752155569; c=relaxed/simple;
	bh=IUOgLyE0XPCQkDQ5QcbdjweqeX7iT7gt/pUXhtCiq7M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RzKulb3RC3DMPVFp8eMO49B7WOrX4TW1OBZjxiDaCOGduyxnQ1dceLMeUxDCeHlkRJEU5j0emNrdRGEKR7yvLTk2d+pToMAbRylOMMYyM9QbVDdZx6UJJqfra9GZdgRk30Ad3/VR5+W+NQ7nB3w7n7uRXW6gKEh813YCMPNzff0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QoRkk9ck; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B7AAB205B3;
	Thu, 10 Jul 2025 13:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752155560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=stHEMGeNbz5JRq98cdiCOEgRTGMVYPBq1E2sda8J0wM=;
	b=QoRkk9ckZddQXHpm4Pbx/E35t4hx1dgASlUABvMZyYL/m2GHgCZEIGqsG3pgFlv6wFRm/M
	4BPtnjQV/sUokpUVF5VOsNsct6YyBj/ryQKtjHaVYMsMDCbbDgCQu4QakiF20Ea4PDhgJk
	k+8+un8SMKRyeBjLeAh8oFllcRHLqVSgZtkw94NtE8Er6X7Fu2pyGzgIoifP7ZAys5RFC9
	JUWTM6JcdVgzOX3DtVKuPR4f/O7A3CC7dUCGrnaWZS/ePOxx0RshfqzMWCS2IC9yYJvNlB
	K9IvwYFYwLWhEf3i9DFYS6DLkMncCXZRyvwa9Wqi54/9UeJyfNy7iDgdaDXPPQ==
Date: Thu, 10 Jul 2025 15:52:37 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: shenwei.wang@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev
Subject: Re: [PATCH net-next 1/3] net: fec: use
 phy_interface_mode_is_rgmii() to check RGMII mode
Message-ID: <20250710155237.2975031f@fedora>
In-Reply-To: <20250710090902.1171180-2-wei.fang@nxp.com>
References: <20250710090902.1171180-1-wei.fang@nxp.com>
	<20250710090902.1171180-2-wei.fang@nxp.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegtdeitdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegveeltddvveeuhefhvefhlefhkeevfedtgfeiudefffeiledttdfgfeeuhfeukeenucfkphepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejpdhhvghlohepfhgvughorhgrpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddupdhrtghpthhtohepfigvihdrfhgrnhhgsehngihprdgtohhmpdhrtghpthhtohepshhhvghnfigvihdrfigrnhhgsehngihprdgtohhmpdhrtghpthhtohepgihirghonhhinhhgrdifrghnghesnhigphdrtghomhdprhgtphhtthhop
 egrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhm
X-GND-Sasl: maxime.chevallier@bootlin.com

On Thu, 10 Jul 2025 17:09:00 +0800
Wei Fang <wei.fang@nxp.com> wrote:

> Use the generic helper function phy_interface_mode_is_rgmii() to check
> RGMII mode.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

