Return-Path: <netdev+bounces-291329-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eD4nE1hZFGofMwcAu9opvQ
	(envelope-from <netdev+bounces-291329-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 16:14:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F845CB9F4
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 16:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74110305FC20
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 13:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C78B2BEFFE;
	Mon, 25 May 2026 13:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ubuntu.com header.i=@ubuntu.com header.b="C3BDyxqb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A0130C17D
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 13:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779717500; cv=none; b=FdqiffOnAIYQaJSaa56OGgz8FgZev/LMYWtkKqxPyxaqCH6DWU791dCLJZ/Co+Ha+EdTyUZ0hl4fzwJOfaOLj9vrc/F9NaZpnqY8fK0IDfQT823+oq2qquDkxoLYdMpmJoQ/YQ5IuFzMVq7A1EZx4cwl6XC4iunp8n+TWOX6IyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779717500; c=relaxed/simple;
	bh=cMwRIGvIt09o6/tnYHncBK0bTpYmYXJsIjtwxL2ZovM=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=BrYhynfWoLFmJCVI6oajhuIT0rHAMErx7JC/MeCqGOytRTrlJXy9RSzlB87J8D8bKYXqMasEQd7k0CF+A5QVFtvIoOZk/RyZCnEck09ChIhAT+f+LxNdGOnuAvYf1pu8rogNa3lrupzGdPrMrCDDGuO0IqHIrXMVsbh4KUS2dIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ubuntu.com; spf=pass smtp.mailfrom=fe-bounces.ubuntu.com; dkim=pass (2048-bit key) header.d=ubuntu.com header.i=@ubuntu.com header.b=C3BDyxqb; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ubuntu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.ubuntu.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ubuntu.com;
 h=In-Reply-To: References: Subject: Cc: To: From: Message-Id: Date:
 Content-Type: Content-Transfer-Encoding: Mime-Version; q=dns/txt;
 s=fe-953a8a3ca9; t=1779717493;
 bh=ZeLnFp9m+pf5y3QIUl8+WeK1RXHgtgz8teGgBVub6X0=;
 b=C3BDyxqbbMYToTZLUTFNg4MrDsXAFOa/Sdw5lBxWDdmB47zOzf/FrEZRgNjF4RbYoDVVEdk/O
 CVKf940kJyVGPkTY52H0Bs+ga5lyONb3DjpdGl17aogKYuRBkgPcjmfH/Bq8LhkmzuB2E135/aF
 /tHi4E/v8UnpzXj8JOx42UIpK2p/ZSOwVWRjFa7z2rzcxvC6wQPlvX81a0zXRPN5DM9qmuLkc9s
 c+tEvbmhGxV8oJvaDKO0MrvzOpY8p5NBE9lhNYHAqhVqDpvE7DBtV0OUkh/fC8pbt+J66tNQScu
 whWPBi7VKhSwbWRCbtsqPbeRzZHQU9dbCsIcqFHAPU0A==
X-Forward-Email-ID: 6a1455716744e73b78d0d539
X-Forward-Email-Sender: rfc822; jpeisach@ubuntu.com, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.8.15
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8; format=Flowed
Date: Mon, 25 May 2026 09:58:06 -0400
Message-Id: <DIRT7260SRQZ.1BFF8CX3FJ57G@ubuntu.com>
From: "Joshua Peisach" <jpeisach@ubuntu.com>
To: "Sasha Finkelstein" <k@chaosmail.tech>, "Sven Peter" <sven@kernel.org>,
 "Janne Grunau" <j@jannau.net>, "Neal Gompa" <neal@gompa.dev>, "Marcel
 Holtmann" <marcel@holtmann.org>, "Luiz Augusto von Dentz"
 <luiz.dentz@gmail.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <asahi@lists.linux.dev>,
 <linux-arm-kernel@lists.infradead.org>, <linux-bluetooth@vger.kernel.org>,
 <netdev@vger.kernel.org>
Subject: Re: [PATCH v3] Bluetooth: Add Broadcom channel priority commands
X-Mailer: aerc 0.21.0
References: <20260525-brcm-prio-v3-1-6259e10233f8@chaosmail.tech>
In-Reply-To: <20260525-brcm-prio-v3-1-6259e10233f8@chaosmail.tech>
X-Spamd-Result: default: False [5.34 / 15.00];
	SEM_URIBL(3.50)[ubuntu.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	MV_CASE(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	R_DKIM_ALLOW(0.00)[ubuntu.com:s=fe-953a8a3ca9];
	TAGGED_FROM(0.00)[bounces-291329-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[chaosmail.tech,kernel.org,jannau.net,gompa.dev,holtmann.org,gmail.com,davemloft.net,google.com,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ubuntu.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jpeisach@ubuntu.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[ubuntu.com,none];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	TO_DN_SOME(0.00)[];
	NEURAL_SPAM(0.00)[0.914];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ubuntu.com:mid,ubuntu.com:dkim,chaosmail.tech:email]
X-Rspamd-Queue-Id: 81F845CB9F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon May 25, 2026 at 8:11 AM EDT, Sasha Finkelstein wrote:
> --- /dev/null
> +++ b/net/bluetooth/brcm.c
> @@ -0,0 +1,38 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2026 The Asahi Linux Contributors
> + */
> +
> +#include <net/bluetooth/bluetooth.h>
> +#include <net/bluetooth/hci_core.h>
> +
> +#include "brcm.h"
> +
> +struct brcm_prio_cmd {
> +	__le16 handle;
> +	u8 enable;
> +} __packed;
> +
> +int brcm_set_high_priority(struct hci_dev *hdev, struct hci_conn *conn,
> +			   bool enable)
> +{
> +	struct sk_buff *skb;
> +	struct brcm_prio_cmd cmd;
> +
> +	if (!hdev->brcm_capable)
> +		return 0;
> +
> +	if (conn->brcm_high_prio =3D=3D enable)
> +		return 0;
> +
> +	cmd.handle =3D cpu_to_le16(conn->handle);
> +	cmd.enable =3D !!enable;
> +

Probably a dumb question, but worth asking - what is the purpose of the
"!!"? Wouldn't just passing "enable" be sufficient?

Also, currently, cmd.enable seems to just be set and used in the case
of boolean conditions. Would it make sense for the enable field in
brcm_prio_cmd to be a bool or does it not really matter?

> +	skb =3D hci_cmd_sync(hdev, 0xfc57, sizeof(cmd), &cmd, HCI_CMD_TIMEOUT);
> +	if (IS_ERR(skb))
> +		return PTR_ERR(skb);
> +
> +	conn->brcm_high_prio =3D enable;
> +	kfree_skb(skb);
> +	return 0;
> +}
> diff --git a/net/bluetooth/brcm.h b/net/bluetooth/brcm.h
> new file mode 100644
> index 000000000000..2290fc6cf798
> --- /dev/null
> +++ b/net/bluetooth/brcm.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2026 The Asahi Linux Contributors
> + */
> +
> +#if IS_ENABLED(CONFIG_BT_BRCMEXT)
> +
> +int brcm_set_high_priority(struct hci_dev *hdev, struct hci_conn *conn,
> +			   bool enable);
> +
> +#else
> +
> +static inline int brcm_set_high_priority(struct hci_dev *hdev,
> +					 struct hci_conn *conn, bool enable)
> +{
> +	return 0;
> +}
> +
> +#endif
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index c46c1236ebfa..0e74bad496a2 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -46,6 +46,7 @@
>  #include "msft.h"
>  #include "aosp.h"
>  #include "hci_codec.h"
> +#include "brcm.h"
> =20
>  static void hci_rx_work(struct work_struct *work);
>  static void hci_cmd_work(struct work_struct *work);
> @@ -3696,6 +3697,9 @@ static void hci_sched_acl_pkt(struct hci_dev *hdev)
> =20
>  			skb =3D skb_dequeue(&chan->data_q);
> =20
> +			if (skb->priority =3D=3D TC_PRIO_INTERACTIVE)
> +				brcm_set_high_priority(hdev, chan->conn, true);
> +
>  			hci_conn_enter_active_mode(chan->conn,
>  						   bt_cb(skb)->force_active);
> =20
>
> ---
> base-commit: 8bc67e4db64aa72732c474b44ea8622062c903f0
> change-id: 20260407-brcm-prio-b630e6cc3834
>
> Best regards,
> -- =20
> Sasha Finkelstein <k@chaosmail.tech>


