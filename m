Return-Path: <netdev+bounces-200521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 571A7AE5D75
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 09:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 550A43BA2EC
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 07:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1FD136658;
	Tue, 24 Jun 2025 07:12:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57247335BA;
	Tue, 24 Jun 2025 07:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750749172; cv=none; b=rrcw7g/CPqKqC0Y4XbJfxLLR+IMh3gNWoJsUPbvb8cTdhT8k5HEbY1yFfg6Ssg7pnkEAGJzw8AUk9OpZvo4tLvkLDOL54+d8DcbB7ycx2guEcrb86l7MzPUNVhBnHn8zUjNPK6kP2CFuR6rkwiJqC5q6oobJO2it7qu9DRU/LYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750749172; c=relaxed/simple;
	bh=hvXeIw6z9bErYdCZo9+wLIAsbPFrMgVsPaWrxP3rMsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xc+szPRhT8/IBVB4XSkHVPX+CbyWLRfEDpugp64ClB9V7P0WKVl8ewfj3aE3FNeITqnQw1uFaKUMb5q1SQraYdIV2Vrv9T+qOUDbbFiAjTJ7xX+MJQLTsF7mT8LAWBgmJzdXHFsf3wCimabtGlP6IdRA+pqMtLBpilBvnIPDSrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.36] (g36.guest.molgen.mpg.de [141.14.220.36])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 62A9761E647A8;
	Tue, 24 Jun 2025 09:12:20 +0200 (CEST)
Message-ID: <c92dd95b-3986-4b0c-807e-62c203a656df@molgen.mpg.de>
Date: Tue, 24 Jun 2025 09:12:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: hci_event: Add support for handling LE BIG
 Sync Lost event
To: Li Yan <yang.li@amlogic.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250624-handle_big_sync_lost_event-v1-1-c32ce37dd6a5@amlogic.com>
 <4db45281-9943-4ed7-80c6-04b39c3e9a5e@molgen.mpg.de>
 <d3ca7e7e-720a-42ef-b32e-19cd84d208a7@amlogic.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <d3ca7e7e-720a-42ef-b32e-19cd84d208a7@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Li,


Thank you for your immediate reply.

Am 24.06.25 um 08:26 schrieb Yang Li:

>> Am 24.06.25 um 07:20 schrieb Yang Li via B4 Relay:
>>> From: Yang Li <yang.li@amlogic.com>
>>>
>>> When the BIS source stops, the controller sends an LE BIG Sync Lost
>>> event (subevent 0x1E). Currently, this event is not handled, causing
>>> the BIS stream to remain active in BlueZ and preventing recovery.
>>
>> How can this situation be emulated to test your patch?
> 
> My test environment is as follows:
> 
> I connect a Pixel phone to the DUT and use the phone as a BIS source for 
> audio sharing. The DUT synchronizes with the audio stream from the phone.
> After I pause the music on the phone, the DUT's controller reports a BIG 
> Sync Lost event.

Excuse my ignorance, but it might be good to have documented. How do you 
connect the Pixel phone to the DUT? Pairing is not needed for BIS 
(Broadcast Isochronous Stream), and using wireless technology no 
connection is needed?

What app do you use on the Android phone?

> I believe this scenario can also be reproduced using the isotest tool. 
> For example:
>   - Use Board A as the BIS source.
>   - Use Board B to execute scan on.
>   - Once Board B synchronizes with Board A, exit isotest on Board A.
>   - Board B should then receive the BIG Sync Lost event as well.

Thank you for sharing this idea.

> Additionally, the following BlueZ patch is required for proper handling 
> of this event:
> https://lore.kernel.org/all/20250624-bap_for_big_sync_lost-v1-1-0df90a0f55d0@amlogic.com/

Yes, I saw it. Thank you.

>>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>>> ---
>>>   include/net/bluetooth/hci.h |  6 ++++++
>>>   net/bluetooth/hci_event.c   | 23 +++++++++++++++++++++++
>>>   2 files changed, 29 insertions(+)
>>>
>>> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
>>> index 82cbd54443ac..48389a64accb 100644
>>> --- a/include/net/bluetooth/hci.h
>>> +++ b/include/net/bluetooth/hci.h
>>> @@ -2849,6 +2849,12 @@ struct hci_evt_le_big_sync_estabilished {
>>>       __le16  bis[];
>>>   } __packed;
>>>
>>> +#define HCI_EVT_LE_BIG_SYNC_LOST 0x1e
>>> +struct hci_evt_le_big_sync_lost {
>>> +     __u8    handle;
>>> +     __u8    reason;
>>> +} __packed;
>>> +
>>>   #define HCI_EVT_LE_BIG_INFO_ADV_REPORT      0x22
>>>   struct hci_evt_le_big_info_adv_report {
>>>       __le16  sync_handle;
>>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>>> index 66052d6aaa1d..730deaf1851f 100644
>>> --- a/net/bluetooth/hci_event.c
>>> +++ b/net/bluetooth/hci_event.c
>>> @@ -7026,6 +7026,24 @@ static void 
>>> hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
>>>       hci_dev_unlock(hdev);
>>>   }
>>>
>>> +static void hci_le_big_sync_lost_evt(struct hci_dev *hdev, void *data,
>>> +                                         struct sk_buff *skb)
>>> +{
>>> +     struct hci_evt_le_big_sync_lost *ev = data;
>>> +     struct hci_conn *conn;
>>> +
>>> +     bt_dev_dbg(hdev, "BIG Sync Lost: big_handle 0x%2.2x", ev->handle);
>>> +
>>> +     hci_dev_lock(hdev);
>>> +
>>> +     list_for_each_entry(conn, &hdev->conn_hash.list, list) {
>>> +             if (test_bit(HCI_CONN_BIG_SYNC, &conn->flags))
>>> +                     hci_disconn_cfm(conn, HCI_ERROR_REMOTE_USER_TERM);
>>> +     }
>>> +
>>> +     hci_dev_unlock(hdev);
>>> +}
>>> +
>>>   static void hci_le_big_info_adv_report_evt(struct hci_dev *hdev, 
>>> void *data,
>>>                                          struct sk_buff *skb)
>>>   {
>>> @@ -7149,6 +7167,11 @@ static const struct hci_le_ev {
>>>                    hci_le_big_sync_established_evt,
>>>                    sizeof(struct hci_evt_le_big_sync_estabilished),
>>>                    HCI_MAX_EVENT_SIZE),
>>> +     /* [0x1e = HCI_EVT_LE_BIG_SYNC_LOST] */
>>> +     HCI_LE_EV_VL(HCI_EVT_LE_BIG_SYNC_LOST,
>>> +                  hci_le_big_sync_lost_evt,
>>> +                  sizeof(struct hci_evt_le_big_sync_lost),
>>> +                  HCI_MAX_EVENT_SIZE),
>>>       /* [0x22 = HCI_EVT_LE_BIG_INFO_ADV_REPORT] */
>>>       HCI_LE_EV_VL(HCI_EVT_LE_BIG_INFO_ADV_REPORT,
>>>                    hci_le_big_info_adv_report_evt,

Kind regards,

Paul

