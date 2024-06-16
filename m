Return-Path: <netdev+bounces-103888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEBA3909FC3
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 22:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E4B1B21208
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 20:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C881649648;
	Sun, 16 Jun 2024 20:45:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FD7101D5;
	Sun, 16 Jun 2024 20:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718570755; cv=none; b=JfOyKrRXtwnV05ZZPJHJGWOBv7IXv0C80UA5WZf3KEKO11pNPfi1SUn1pqur0QPuOczXZxTlYS/W/ZH2BJSCb0lN7Cvvl3tg+1MeEehrhbSpVkPnDoWBJtQy5kAVeNCndL3DMsIPO1jPnA6OGQ+tMS7X3CP1YGODDAg59F9Se7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718570755; c=relaxed/simple;
	bh=uqekU8Prqoy8LIbzqidIjup254UaLrJ2IY4p+bxQbnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=npGBFyl++ELzQ9jXJNgM7K1cSBLfBPBNX3Uw7b6oklVx66N2yKJ7Ics27wJ9QSmS8XhUi2UTCxaV8brd0xthsNb8adNwSTFQTxMXmJAkJjmbuGiVHItsrJL1GTnFUNXpvZZVGNJ+XXaGrY6zy0qV1zJfzHLcF5fJEc9jkz9EZeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.53] (ip5f5aea72.dynamic.kabel-deutschland.de [95.90.234.114])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 2791A61E5FE06;
	Sun, 16 Jun 2024 22:44:47 +0200 (CEST)
Message-ID: <f3ae861f-d030-47c6-9eec-5a197b875e0b@molgen.mpg.de>
Date: Sun, 16 Jun 2024 22:44:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: handle value is too large should not be used
 in BIG
To: Edward Adam Davis <eadavis@qq.com>
Cc: davem@davemloft.net, edumazet@google.com, johan.hedberg@gmail.com,
 kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
 luiz.von.dentz@intel.com, marcel@holtmann.org, netdev@vger.kernel.org,
 pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
 william.xuanziyang@huawei.com
References: <666ec579.050a0220.39ff8.d4a2@mx.google.com>
 <tencent_410DFAA59E0DBA9213DDE8DD9399584FDB07@qq.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <tencent_410DFAA59E0DBA9213DDE8DD9399584FDB07@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Edward,


Thank you for your patch. It’d be nice if you made the commit message 
about the action, like:

Bluetooth: Ignore too large handle values in BIG

Am 16.06.24 um 15:21 schrieb Edward Adam Davis:
> hci_le_big_sync_established_evt is necessary to filter out cases where the
> handle value is belone to ida id range, otherwise ida will be erroneously

belone? Is it belonging?

> released in hci_conn_cleanup.
> 
> Fixes: 181a42edddf5 ("Bluetooth: Make handle of hci_conn be unique")
> Reported-by: syzbot+b2545b087a01a7319474@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=b2545b087a01a7319474
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>   net/bluetooth/hci_event.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index a487f9df8145..eb1d5a2c48ee 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -6893,6 +6893,9 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
>   
>   		bis = hci_conn_hash_lookup_handle(hdev, handle);
>   		if (!bis) {
> +			if (handle > HCI_CONN_HANDLE_MAX)
> +				continue;
> +

Should some debug message be printed?

>   			bis = hci_conn_add(hdev, ISO_LINK, BDADDR_ANY,
>   					   HCI_ROLE_SLAVE, handle);
>   			if (IS_ERR(bis))


Kind regards,

Paul

