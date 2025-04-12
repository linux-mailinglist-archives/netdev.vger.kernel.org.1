Return-Path: <netdev+bounces-181882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94994A86BDC
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 10:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A1448C0D9F
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 08:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609511922ED;
	Sat, 12 Apr 2025 08:40:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vuizook.err.no (vuizook.err.no [178.255.151.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9FC1632C8
	for <netdev@vger.kernel.org>; Sat, 12 Apr 2025 08:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.255.151.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744447202; cv=none; b=F8dgAbOv0cvZlYoYYkb0A/Mbn1cI62W0XAJv0BVnEyGrIMtrYgya/ysTSqx40sBwcs2moy6yKIlMJzOYa30xRdKpX6z97mGRHDDvbORXtM6DoWQOsb5W6jUK2o+TbgjPnDSawOM/uxTF1d4IEzIZfc42VYVLaI2RnLPJcgLdsmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744447202; c=relaxed/simple;
	bh=zABR6WSHXaIMOoCHJhF9OsTL9e2JJE7bAB7M3ddXMGw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VrymVu4QrtMhT5z989ppqpuPvN20gOISPlQhTwVcJkHuDuZaFEH/zGR/+U9qrJpJjS91RNOnvXj9Yrr4SoR556GkbAOEHL2fNacXFt3HBM7GjvABA1I5qIMFR0Cpts0+tuXAqDpJF66BFdhMhysBAQ6w1ePrUYWYa7E+FCSerPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hungry.com; spf=none smtp.mailfrom=hungry.com; arc=none smtp.client-ip=178.255.151.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hungry.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=hungry.com
Received: from [2a02:fe1:180:7c00:3cca:aff:fe28:58e0] (helo=hjemme.reinholdtsen.name)
	by vuizook.err.no with smtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <pere@hungry.com>)
	id 1u3WOz-00DqBx-22;
	Sat, 12 Apr 2025 08:39:54 +0000
Received: (nullmailer pid 2369751 invoked by uid 10001);
	Sat, 12 Apr 2025 08:39:47 -0000
From: Petter Reinholdtsen <pere@hungry.com>
To: Salvatore Bonaccorso <carnil@debian.org>, Michal Kubecek <mkubecek@suse.cz>
Cc: netdev@vger.kernel.org, Daniel Rusek <asciiwolf@seznam.cz>, Michal Kubecek <mkubecek@suse.cz>
Subject: Re: [PATCH ethtool] Set type property to console-application for
 provided AppStream metainfo XML
In-Reply-To: <Z_n7jpRVr_Sv-gxC@eldamar.lan>
References: <20250411141023.14356-2-carnil@debian.org>
 <Z_mKHHSNscT09VwJ@eldamar.lan> <sa65xjaromx.fsf@hjemme.reinholdtsen.name>
 <Z_n7jpRVr_Sv-gxC@eldamar.lan>
Date: Sat, 12 Apr 2025 10:39:47 +0200
Message-ID: <sa634edsrho.fsf@hjemme.reinholdtsen.name>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

[Salvatore Bonaccorso]
> Can we add a Tested-by: Petter Reinholdtsen <pere@hungry.com> ?

Sure. :)

> I think at least the summary-first-word-not-capitalized should be done
> in a seprate commit? Not sure about the other two reported info level
> issues.

Note, I believe neither of them need to be addressed, as they are minor
nitpick issues that do not affect the usefulnes of the entry, and only
affect the amount of noise from appstreamcli validate-tree. :)

-- 
Happy hacking
Petter Reinholdtsen

