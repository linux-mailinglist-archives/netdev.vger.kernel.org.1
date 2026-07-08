Return-Path: <netdev+bounces-305818-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id E1q6HZtRTmq0KgIAu9opvQ
	(envelope-from <netdev+bounces-305818-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 15:33:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5165726D40
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 15:33:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=TaubQALa;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305818-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305818-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03AC3304D726
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 13:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1304034389F;
	Wed,  8 Jul 2026 13:28:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B7E279DB1;
	Wed,  8 Jul 2026 13:28:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783517315; cv=none; b=oHtcHa4fixPSKCM3A61MkrGAghoVX+3NBYy/9EUA7JiOk/jksuT9V3utla/bpLb9lvKPceIdhnybgoOGi1F+YqfDi6LGOuFaxfd+NdaneDs8YoT7032hq8kjlVzpRs4gAPuermEb3EiiDf/T3HzUck5SMuf9kg0r5H/I+Oj4Eb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783517315; c=relaxed/simple;
	bh=VlodVEQ6+GftqGSGNgImGJIJgM9xsfht7v9YA5Qk5k4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jXf+SBd8ChxqdQnS+dcMyE1MUGt2/EiubOUT+8VDvesSKcsWfkNohTg9+fCKajlja2Nq1cDvzFw53f1gOAZCa/seRo7klYTeoc5cJtwyjXy0mqBxGczmKaI4e1TOwyaZXzg/MSmeKZAitjVp2JhjKsMr4HZezblNArhqlZQCeP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TaubQALa; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDECC1F00A3A;
	Wed,  8 Jul 2026 13:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783517312;
	bh=3Bx4681CKO0D9gdlCFKTpw12ogc4wsugK3EjcSTcZF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TaubQALaKUDIjGIkVYRAFJZXvP9LEoIT2ZGuPNqQeaoI8Kyb1JAgV56D0v39wWzCb
	 LbifiX/ONMNNpezsb5fmhjf3pc8yMzzfqa8/RrK/NNfKpVP86nodHT/uOile/jT39u
	 2GqeCK1JwYGTFwxK/+lCc0p7A1cRZvwJw30WNqcsAzkB+CPmdhk7WciRWdlzX90jbQ
	 I4AIOUC/abiBELWNu9awiNsVZdZmtRqFdaFeOhVCYAZVZBo4Pqz51BoueyItCoSSnl
	 ekbjckR0pExODLSltqfj3sSh7Y5inr3jj6e2JtUOXQKbe+hRXS7kJBMwnUHyhwG9Qe
	 /Rh8vW22LMkPA==
From: Simon Horman <horms@kernel.org>
To: sanghyun.park.cnu@gmail.com
Cc: Simon Horman <horms@kernel.org>,
	david+nfc@ixit.cz,
	krzk@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ian.ray@gehealthcare.com,
	joe@dama.to,
	kuniyu@google.com,
	kees@kernel.org,
	ashutoshdesai993@gmail.com,
	vadim.fedorenko@linux.dev,
	deepak.sharma.472935@gmail.com,
	michael.thalmeier@hale.at,
	christophe.ricard@gmail.com,
	sameo@linux.intel.com,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] nfc: nci: Fix conn_info use-after-free
Date: Wed,  8 Jul 2026 14:28:07 +0100
Message-ID: <20260708132806.1485690-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260630071717.3618185-2-sanghyun.park.cnu@gmail.com>
References: <20260630071717.3618185-2-sanghyun.park.cnu@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:sanghyun.park.cnu@gmail.com,m:horms@kernel.org,m:david+nfc@ixit.cz,m:krzk@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ian.ray@gehealthcare.com,m:joe@dama.to,m:kuniyu@google.com,m:kees@kernel.org,m:ashutoshdesai993@gmail.com,m:vadim.fedorenko@linux.dev,m:deepak.sharma.472935@gmail.com,m:michael.thalmeier@hale.at,m:christophe.ricard@gmail.com,m:sameo@linux.intel.com,m:oe-linux-nfc@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sanghyunparkcnu@gmail.com,m:david@ixit.cz,m:deepaksharma472935@gmail.com,m:christophericard@gmail.com,s:lists@lfdr.de];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,ixit.cz,davemloft.net,google.com,redhat.com,gehealthcare.com,dama.to,gmail.com,linux.dev,hale.at,linux.intel.com,lists.linux.dev,vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,nfc];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-305818-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C5165726D40

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
nfc: nci: Fix conn_info use-after-free

This commit fixes a use-after-free in nci_tx_work() by introducing a dedicated
spinlock (conn_info_lock) to protect the conn_info_list and conn_info aliases
during lookup, insertion, and removal.

> diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
> --- a/net/nfc/nci/core.c
> +++ b/net/nfc/nci/core.c
> @@ -1333,11 +1367,16 @@ void nci_unregister_device(struct nci_dev *ndev)
>  	destroy_workqueue(ndev->rx_wq);
>  	destroy_workqueue(ndev->tx_wq);
>  
> +	spin_lock_bh(&ndev->conn_info_lock);
>  	list_for_each_entry_safe(conn_info, n, &ndev->conn_info_list, list) {
>  		list_del(&conn_info->list);
> +		if (conn_info == ndev->rf_conn_info)
> +			ndev->rf_conn_info = NULL;
> +		if (conn_info == ndev->hci_dev->conn_info)
> +			ndev->hci_dev->conn_info = NULL;

[Severity: Critical]
Can this cause a NULL pointer dereference for devices without HCI support?

For NCI devices without HCI support (like nfcmrvl or s3fwrn5), ndev->hci_dev
is NULL. Because all NCI devices add at least the static RF connection to
conn_info_list during discovery, this loop will always execute.

Evaluating conn_info == ndev->hci_dev->conn_info will crash when
ndev->hci_dev is NULL.

Should this check ndev->hci_dev before accessing its conn_info field? The
same issue appears in nci_core_conn_close_rsp_packet() in net/nfc/nci/rsp.c.

> diff --git a/net/nfc/nci/data.c b/net/nfc/nci/data.c
> --- a/net/nfc/nci/data.c
> +++ b/net/nfc/nci/data.c
> @@ -171,40 +174,47 @@ static int nci_queue_tx_data_frags(struct nci_dev *ndev,
[ ... ]
> +	spin_lock_bh(&ndev->conn_info_lock);
>  	ndev->cur_conn_id = conn_id;
> -	queue_work(ndev->tx_wq, &ndev->tx_work);

[Severity: High]
This is a pre-existing issue, but does ndev->cur_conn_id suffer from
concurrent overwrites?

If a logical connection is being closed, nci_core_conn_close() sets
ndev->cur_conn_id and waits for the response.

If nci_send_data() is called concurrently, it overwrites ndev->cur_conn_id
without holding req_lock.

When the close response arrives, nci_core_conn_close_rsp_packet() will free
the conn_info for the actively transmitting connection instead of the closed
one. Does cur_conn_id need better protection or a different tracking
mechanism?

> @@ -282,11 +292,15 @@ void nci_rx_data_packet(struct nci_dev *ndev, struct sk_buff *skb)
[ ... ]
>  	/* strip the nci data header */
>  	skb_pull(skb, NCI_DATA_HDR_SIZE);

[Severity: High]
This is a pre-existing issue, but can this lead to an out-of-bounds read
if the packet is empty?

If a target sends an empty packet (skb->len == 0), the skb_pull() just above
fails gracefully leaving skb->len at 0.

Then in nci_rx_data_packet(), the code accesses skb->data[skb->len - 1] to
read the status byte, reading out-of-bounds memory.

Does this need an skb->len > 0 check before accessing the status byte?

> diff --git a/net/nfc/nci/hci.c b/net/nfc/nci/hci.c
> --- a/net/nfc/nci/hci.c
> +++ b/net/nfc/nci/hci.c
> @@ -599,10 +632,20 @@ int nci_hci_set_param(struct nci_dev *ndev, u8 gate, u8 idx,
[ ... ]
> +		message = (struct nci_hcp_message *)rx_skb->data;
>  		r = nci_hci_result_to_errno(
>  			NCI_HCP_MSG_GET_CMD(message->header));
> -		skb_pull(conn_info->rx_skb, NCI_HCI_HCP_MESSAGE_HEADER_LEN);
> +		skb_pull(rx_skb, NCI_HCI_HCP_MESSAGE_HEADER_LEN);
> +		spin_unlock_bh(&ndev->conn_info_lock);
>  	}

[Severity: High]
This is a pre-existing issue, but does this leak the response skb?

After pulling the header to check the result, nci_hci_set_param() returns
without consuming the skb or calling kfree_skb().

The buffer remains in conn_info->rx_skb, and the next time an HCI response
is received, nci_hci_resp_received() unconditionally overwrites the pointer,
permanently leaking the memory.

Should the skb be freed if it's not being passed back to the caller?

> diff --git a/net/nfc/nci/rsp.c b/net/nfc/nci/rsp.c
> --- a/net/nfc/nci/rsp.c
> +++ b/net/nfc/nci/rsp.c
> @@ -298,20 +313,20 @@ static void nci_core_conn_create_rsp_packet(struct nci_dev *ndev,
>  		conn_info->dest_params->id = ndev->cur_params.id;
>  		conn_info->dest_params->protocol = ndev->cur_params.protocol;
>  		conn_info->conn_id = rsp->conn_id;
> +		conn_info->max_pkt_payload_len = rsp->max_ctrl_pkt_payload_len;
> +		atomic_set(&conn_info->credits_cnt, rsp->credits_cnt);

[Severity: High]
This is a pre-existing issue, but does this properly validate the length
of the response packet?

The skb->data is cast to struct nci_core_conn_create_rsp, but if the
hardware sends a truncated response (e.g., just the status byte), the code
blindly accesses the connection parameters and credit count from
uninitialized adjacent memory.

Does this need an skb->len check before parsing the structure?

