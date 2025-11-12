Return-Path: <netdev+bounces-237924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE151C5185A
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 10:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA84618820F3
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 09:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47C33002A9;
	Wed, 12 Nov 2025 09:56:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586F82FF663;
	Wed, 12 Nov 2025 09:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762941386; cv=none; b=BvMDMgLem2ZfztCZfVRa5xwPEKgEVrVGGAUHKNzlVlwQT7a/tkwGQ301i3lzbW9vvIezYhr+BSZgpYWjmyPIO0fAE9Ws8QspxHdj/15NEMnZK8G4/GTthhq26gtUOKxNq8Y1l73gSYqTXohuFZftRK6rtQaX1VDgAEOSgPdUdn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762941386; c=relaxed/simple;
	bh=cslFZpQ7jV9CKrGaEhC7YVXSe928JWEpLIJ3j4lGY2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cx/Bw8NFM+erSD2i/VF35ln603SeprQtNFiw0fV7HloljSeJ2Bm6bWBNDw0wJjjPnGZA8soMgTi3SatZ4gxwCgrxBM5LQUU7uPTzmTdZNWAlhEOtr6WntDp56eYX8ROdsK3q5U/hRfTnKZ6buKhxFtMGLO4YM6xY1mfxJzleXCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.215] (p57bd98fa.dip0.t-ipconnect.de [87.189.152.250])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 854F561CC3FD1;
	Wed, 12 Nov 2025 10:56:02 +0100 (CET)
Message-ID: <472c08c3-046a-4f16-ae88-c101ff6b7262@molgen.mpg.de>
Date: Wed, 12 Nov 2025 10:55:58 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] Bluetooth: Process Read Remote Version evt
To: Gongwei Li <13875017792@163.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gongwei Li <ligongwei@kylinos.cn>
References: <20251112094843.173238-1-13875017792@163.com>
 <20251112094843.173238-2-13875017792@163.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20251112094843.173238-2-13875017792@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Gongwei,


Thank you for your patch. I’d spell out event in the commit message 
summary/title.

Am 12.11.25 um 10:48 schrieb Gongwei Li:
> From: Gongwei Li <ligongwei@kylinos.cn>
> 
> Add processing for HCI Process Read Remote Version event.
> Used to query the lmp version of remote devices.

How did you test it?

> Signed-off-by: Gongwei Li <ligongwei@kylinos.cn>
> ---
>   include/net/bluetooth/hci_core.h |  1 +
>   net/bluetooth/hci_event.c        | 23 +++++++++++++++++++++++
>   net/bluetooth/mgmt.c             |  5 +++++
>   3 files changed, 29 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 32b1c08c8bba..bdd5e6ef3616 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -749,6 +749,7 @@ struct hci_conn {
>   
>   	__u8		remote_cap;
>   	__u8		remote_auth;
> +	__u8		remote_ver;
>   
>   	unsigned int	sent;
>   
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index f20c826509b6..7f8e3f8ec01e 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -3737,6 +3737,26 @@ static void hci_remote_features_evt(struct hci_dev *hdev, void *data,
>   	hci_dev_unlock(hdev);
>   }
>   
> +static void hci_remote_version_evt(struct hci_dev *hdev, void *data,
> +				   struct sk_buff *skb)
> +{
> +	struct hci_ev_remote_version *ev = (void *)skb->data;
> +	struct hci_conn *conn;
> +
> +	BT_DBG("%s", hdev->name);
> +
> +	hci_dev_lock(hdev);
> +
> +	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->handle));
> +	if (!conn)
> +		goto unlock;
> +
> +	conn->remote_ver = ev->lmp_ver;
> +
> +unlock:
> +	hci_dev_unlock(hdev);
> +}
> +
>   static inline void handle_cmd_cnt_and_timer(struct hci_dev *hdev, u8 ncmd)
>   {
>   	cancel_delayed_work(&hdev->cmd_timer);
> @@ -7448,6 +7468,9 @@ static const struct hci_ev {
>   	/* [0x0b = HCI_EV_REMOTE_FEATURES] */
>   	HCI_EV(HCI_EV_REMOTE_FEATURES, hci_remote_features_evt,
>   	       sizeof(struct hci_ev_remote_features)),
> +	/* [0x0c = HCI_EV_REMOTE_VERSION] */
> +	HCI_EV(HCI_EV_REMOTE_VERSION, hci_remote_version_evt,
> +	       sizeof(struct hci_ev_remote_version)),
>   	/* [0x0e = HCI_EV_CMD_COMPLETE] */
>   	HCI_EV_REQ_VL(HCI_EV_CMD_COMPLETE, hci_cmd_complete_evt,
>   		      sizeof(struct hci_ev_cmd_complete), HCI_MAX_EVENT_SIZE),
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 79762bfaea5f..c0bab45648f3 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -9728,6 +9728,9 @@ void mgmt_device_connected(struct hci_dev *hdev, struct hci_conn *conn,
>   {
>   	struct sk_buff *skb;
>   	struct mgmt_ev_device_connected *ev;
> +	struct hci_cp_read_remote_version cp;
> +
> +	memset(&cp, 0, sizeof(cp));
>   	u16 eir_len = 0;
>   	u32 flags = 0;
>   
> @@ -9774,6 +9777,8 @@ void mgmt_device_connected(struct hci_dev *hdev, struct hci_conn *conn,
>   	ev->eir_len = cpu_to_le16(eir_len);
>   
>   	mgmt_event_skb(skb, NULL);
> +
> +	hci_send_cmd(hdev, HCI_OP_READ_REMOTE_VERSION, sizeof(cp), &cp);
>   }
>   
>   static void unpair_device_rsp(struct mgmt_pending_cmd *cmd, void *data)

The diff looks good. Please feel free to add:

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

