Return-Path: <netdev+bounces-240676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A48C7794E
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 07:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 7A5622CB10
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 06:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8522632FA17;
	Fri, 21 Nov 2025 06:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="Na7DWAKw"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAAB32F74A
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 06:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763706722; cv=none; b=MEnIoz/jkQorT92nJE5h7SHuFfKvGTjqSYDF4Jx5b1IS/+OxJXe9JZeimu23+1zNsEbzB+6Wi3eTNSoVM+Rnfqi4VDnqkNlaPPA08zVupUeokJNARFNJ5FGtbHIxKEuE6OFcPu31eajimaijo7I1QFZaS6/V0bWv6zIUS8jg8iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763706722; c=relaxed/simple;
	bh=A8G7TP69kECO+1gwzAdFDb+eJTaB6RV03QIkYqGegZQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uG+JB0lggFjpyUCcQvU3E0ShJj4za0N1z0ZbiFKrmfwWWCkC8qhizXYXFFTQQMvy7Pg+j4Unaekgi7j5cCrravBh7mK899z2gpHRxAe4pjYcNSMIlAHBBR+ZQdjxGLZc5kGut6TDK2ZiJlpEiExQCCH1fy1+JoCCGznjB2fDa/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=Na7DWAKw; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 0CA74A0CC8
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 07:31:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:content-type:content-type:date:from:from:message-id
	:mime-version:reply-to:subject:subject:to:to; s=mail; bh=A8G7TP6
	9kECO+1gwzAdFDb+eJTaB6RV03QIkYqGegZQ=; b=Na7DWAKwm4Ly6ohd0BFySEa
	fY0TboBCfzINa6RbPGcD/GNoxsgtJaRfWPiyyvINBvaXQ6sPebxc2rgjCh9sYcoh
	F/SGbz2PxY0nYYeLpm167t769GnBqpIg1WnXye1L+iSAbL08xAThnNBJ1nC0Dej+
	bUEoDs5nyqCjvlGmjOskLkT35Re36bp02W07PXOLtVXiH777daNl0/uxwTAhGz+m
	X1Qb/7DNATVxfBVCJJCRNswQvIpp+1zXKVPVj5ybH0vGRbAC7qn4VyslIJPT7K/l
	qu1/vLAdJPATFVLvf2RMSFDuesm7bLRASadQuzwT7zpD3FiV+0F6lTbmXgPs5xO4
	FSkjCZ1g4ls5p3nE6pW8lNPMpfL3KZKNchE0bjGMfeqt3cMZgZsk+2QEVp+I5YHN
	kkKt/+l4JDTFxYhYUH4z9MIKPBCAyng63r9ykbvgNIyjhNvwjBx2OAqVkxYe9y81
	1iE4P6VKdRNa9jXdE3LSBdwn0gfixw385NJJGN7QK2ilHGEotldhmlUy+6vm4HUg
	qcocoPbD3HM3AbfkFr6h+MK1prU9fQ1HWNdACoKS1F28enyWhwNeX74YPCINt27T
	BJchRr7TvZu0gH03oHJNfudlFnjY6M+8ott202V4MT3/GYH08uAkm2+r1PC1SwbU
	fx+g1ACKfZ21D+YMrCUs=
Date: Fri, 21 Nov 2025 07:31:48 +0100
From: Buday Csaba <buday.csaba@prolan.hu>
To: <netdev@vger.kernel.org>
Subject: [Question] Return value of mii_bus->write()
Message-ID: <aSAHVPsxrM60lRIj@debianbuilder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1763706708;VERSION=8002;MC=3771310116;ID=105653;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155F60756A

I am preparing a patch to eliminate kernel-doc warnings in mdio_device.c
and mdio_bus.c

I have ran into an ambiguity: what is mii_bus->write() supposed to
return on success? Documentation/networking/phy.txt does not give any
information about it, neither does the kdoc in include/linux/phy.h.

It is clear that 0 is treated as success, and a negative indicates
failure. The reference implementation also follows this convention.
But the code in mdio_bus.c, for example: __mdiobus_modify_changed(),
seems to also expect positive return values from write().

Is there any other implementation that allows positive return
values for success? Should it be mentioned in kernel-doc?

Thanks,
Csaba


