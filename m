Return-Path: <netdev+bounces-184349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5F2A94E6A
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 11:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 613583A9462
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 09:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28EA20FAA8;
	Mon, 21 Apr 2025 09:07:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EDF20D51A
	for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 09:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745226459; cv=none; b=bGxh5FrEqg/xSa4V9FYnUKiwynpdsA3JFOLYsfQf9K6mLQ3ACBl/OtGPHa0aHklgnNen21dP67pLnx0oET999XxPu3k+FqwR04kxUHqrXaWWI8vdit7Nb96u7Gp+KWGPKZ5aq0PLTLoBR2oWQNTLfY3yIjB1NlN8o9GEq1fSGuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745226459; c=relaxed/simple;
	bh=vdUzWa63sg6Pdl+DuhYlHslX+KbaUoBZ0LA4Mwn58vs=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=YZsylFuV+mZaFrcXV+WuXZyBEKoyJwiSWCqee/KJiG8tx+OT5+DnddXoZHy8qECAAEAQ31Qq9vxaeRjpg1HW1r7YuGpZlxKwHyTh0Rip/gcRQvql8zmf9hQtTu2BmsItv27sABVwzyXre+Lo3SfuwgNboFjCVyl5xLXh8Yib2f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn; spf=pass smtp.mailfrom=mails.ucas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.ucas.ac.cn
Received: from [10.31.1.120] (unknown [210.76.195.148])
	by APP-01 (Coremail) with SMTP id qwCowACHMQLICgZoOmjKCg--.57830S2;
	Mon, 21 Apr 2025 17:07:21 +0800 (CST)
Message-ID: <8b96e37c-842b-4afb-9c61-f71674874be5@mails.ucas.ac.cn>
Date: Mon, 21 Apr 2025 17:07:20 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Content-Language: en-US
To: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Cc: netdev@vger.kernel.org, Ivan Vecera <ivecera@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>
From: Qiyu Yan <yanqiyu17@mails.ucas.ac.cn>
Subject: [?bug] Can't get switchdev mode work on ConnectX-4 Card
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACHMQLICgZoOmjKCg--.57830S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tr4xXry5JFyfKF43Cr4DArb_yoW8AFy7p3
	yruwnxKFy8J340q3Z7uryUWFyrt34DJa1UGr4xGF1YvFs7Ww1jgr18ZF4Y934DAF409ryU
	tFyqyw1v93yYkaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9G14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7
	MxkF7I0En4kS14v26r126r1DMxkF7I0Ew4C26cxK6c8Ij28IcwCF04k20xvY0x0EwIxGrw
	CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
	14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
	IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxK
	x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
	0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUU1SotUUUUU==
X-CM-SenderInfo: 51dq1xl1xrlqxpdlz24oxft2wodfhubq/1tbiDAgTB2gF8jJuUgAAsB

Hi,

I have a ConnectX-4 Lx EN MCX4121A-acat card:

$ lspci -s c1:00.0
c1:00.0 Ethernet controller: Mellanox Technologies MT27710 Family 
[ConnectX-4 Lx]
$ devlink dev info pci/0000:c1:00.0
pci/0000:c1:00.0:
   driver mlx5_core
   versions:
       fixed:
         fw.psid MT_2420110034
       running:
         fw.version 14.32.1900
         fw 14.32.1900
       stored:
         fw.version 14.32.1900
         fw 14.32.1900

I wanted to put the card to switchdev mode, so I started trying to to 
the following:

# enable switchdev mode
$ sudo devlink dev eswitch set pci/0000:c1:00.0 mode switchdev
$ sudo devlink dev eswitch show pci/0000:c1:00.0
pci/0000:c1:00.0: mode switchdev inline-mode link encap-mode basic

# create 2 VFs
$ echo 2 | sudo tee /sys/class/net/mlx-p0/device/sriov_numvfs

# Try add interface to bridges
$ sudo ip link add vmbr type bridge
$ sudo ip link set mlx-p0 master vmbr
Error: mlx5_core: Error checking for existing bridge with same ifindex.
$ sudo ip link set enp193s0f0r0 master vmbr
Error: mlx5_core: Error checking for existing bridge with same ifindex.

when the failure happens, there are messages like this in kmsg:

mlx5_core 0000:c1:00.0 mlx-p0: entered allmulticast mode
mlx5_core 0000:c1:00.0 mlx-p0: left allmulticast mode
mlx5_core 0000:c1:00.0 mlx-p0: failed (err=-22) to set attribute (id=6)

I am wondering if this is a bug in the current driver or anything above 
is wrong?

Some additional information:

(Fedora stock kernel 6.14.2-300.fc42.x86_64)
$ uname -a
Linux epyc-server 6.14.2-300.fc42.x86_64 #1 SMP PREEMPT_DYNAMIC Thu Apr 
10 21:50:55 UTC 2025 x86_64 GNU/Linux
$ rpm -q iproute
iproute-6.12.0-3.fc42.x86_64

Best,
Qiyu


