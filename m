Return-Path: <netdev+bounces-153927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF9F9FA143
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 16:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F468168A62
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 15:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715F31F4726;
	Sat, 21 Dec 2024 15:14:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zenith.plouf.fr.eu.org (plouf.fr.eu.org [213.41.155.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5771E1B85DF
	for <netdev@vger.kernel.org>; Sat, 21 Dec 2024 15:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.41.155.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734794072; cv=none; b=tPc3Wrsh8NaoP72aBzBmXKOsTiShMkvwQBk/U4Rdq0K7lYupsjAEMU+e0ii2fv/3lJPWnkhFvbD4wHmRaWeTQAjsM5IMyEl9XAoMLWE7h1h0p5AfVOLSz+cL8k/iGyzoqwYky9kvrjsXF4MnGZ2SMz686dA0XHMBPFPV+vZU3FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734794072; c=relaxed/simple;
	bh=KybL7EuFGQgal1sr7uI3oDjEonXxRJSNEfqzYh7kMvc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=RCnHD9l/wZLOA6G/Efg6OsKfdAr9b3TQbhrxXPKUJMbFg33VshaesYYzLApcCoeDeQEDOIEy2idEUgvIfRR5HVepDDiHZS9+SQEIaSSVdLYuvNwPz8uEivlVeR9i/K+pszc3CPWHigIL99+d1I1ow0HBTfsXwQu+OaznzpYKufg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=plouf.fr.eu.org; spf=pass smtp.mailfrom=plouf.fr.eu.org; arc=none smtp.client-ip=213.41.155.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=plouf.fr.eu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=plouf.fr.eu.org
Received: from [192.168.0.252]
	by zenith.plouf.fr.eu.org with esmtp (Exim 4.89)
	(envelope-from <pascal@plouf.fr.eu.org>)
	id 1tP0eQ-0007kE-3W; Sat, 21 Dec 2024 15:40:18 +0100
Message-ID: <4ba0418d-0e64-4685-a345-cc5b6bac3b61@plouf.fr.eu.org>
Date: Sat, 21 Dec 2024 15:40:12 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Pascal Hambourg <pascal@plouf.fr.eu.org>
Subject: sky2: Add 11ab:4373 to the supported PCI ID list
Organization: Plouf !
To: Mirko Lindner <mlindner@marvell.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear sky2 maintainers,

Ethernet controller 11ab:4373 is not in sky2 PCI device ID list but 
after running

# modprobe sky2
# echo 11ab 4373 > /sys/bus/pci/drivers/sky2/new_id
# lspci -kd ::200
02:00.0 Ethernet controller: Marvell Technology Group Ltd. Device 4373 
(rev 10)
	Subsystem: Samsung Electronics Co Ltd Device c102
	Kernel driver in use: sky2
	Kernel modules:

it appears that the network interface works fine.
Could this device ID be added to the supported list ?

