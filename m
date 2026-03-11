Return-Path: <netdev+bounces-266543-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Ni4GxYusWkVrwIAu9opvQ
	(envelope-from <netdev+bounces-266543-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 09:55:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AA625FD19
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 09:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D0D87300A4D2
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 08:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B67E28507B;
	Wed, 11 Mar 2026 08:55:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666D13C0630;
	Wed, 11 Mar 2026 08:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773219345; cv=none; b=l4swx8Tr3IzyBB0V+3w8Kc2Fi3OTgyTlB5VYm54X9xJuRtnKU+G58VI7Da+6N7Kg/ellqx1kX22cN1Tf/C/65MGnjfDU/Itw2MuIraUZQHuhRQ/cMzbBhAjcLvkG3QQ3GaD9if7rGSrnUYSbg7h5jO4CTfrnyOv21Q0IGueif5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773219345; c=relaxed/simple;
	bh=9uyyFVC+dEr2i7ZqlE+cIRl9d4bFHWF9vTTuUqpF34A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bwps5svajYrnon5uZ5LwuAJcu329ACUIEVrfOJSzRwCPF/ftZ8ky7fTzJeKEabBIwtIgzsf4/u81JVbRM5qLTa9vVANr1KgyQbSjRboTGUxk0agLUJBUutog4+DPyhULIRqNLa2wi2NkB3+f2f+C8EuKX6vvkhdiq//GEnBJzbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.228] (p57bd9914.dip0.t-ipconnect.de [87.189.153.20])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 2088E4C2C37D70;
	Wed, 11 Mar 2026 09:54:40 +0100 (CET)
Message-ID: <9199a462-09be-402a-a47a-447e51a2f5a4@molgen.mpg.de>
Date: Wed, 11 Mar 2026 09:54:38 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: ISO: add timestamp for outgoing HCI ISO packet
To: Tailu Shi <tailu.shi@samsung.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Pauli Virtanen <pav@iki.fi>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <CGME20260311081515epcas5p44f035a61a5c6738cd6017d961bf68326@epcas5p4.samsung.com>
 <20260311081401.3832000-1-tailu.shi@samsung.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260311081401.3832000-1-tailu.shi@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D5AA625FD19
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266543-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[mpg.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[holtmann.org,gmail.com,iki.fi,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.378];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmenzel@molgen.mpg.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,samsung.com:email,gitlab.freedesktop.org:url,user.name:url,mpg.de:email]
X-Rspamd-Action: no action

Dear Tailu,


Thank you for your patch. A formal request at the beginning to please 
spell your name without the dot/period – maybe: Tailu Shi.

     git config --global user.name "Tailu Shi"
     git commit --amend -s --author="Tailu Shi <tailu.shi@samsung.com>"

Am 11.03.26 um 09:14 schrieb tailu.shi:
> The Bluetooth Core Specification defines the 'Time_Stamp' field of
> an HCI ISO packet as optional. However, it's mandatory to include
> the 'Time_Stamp' field when using HCI ISO packets per section 3.3
> 'HCI Feature Support Requirement' of TMAP specification.
> https://www.bluetooth.com/specifications/specs/html/?src=TMAP_v1.0.1/out/en/index-en.html#UUID-68138fa8-fd1f-1a1b-e552-ddcd8fede9ec
> 
> To comply with TMAP, introduce a new socket option BT_PKT_ISO_TIMESTAMP
> that allows user application (e.g. PipeWire) to attach timestamp to the
> data it sends to the ISO socket within BT_SCM_PKT_ISO_TIMESTAMP CMSG.
> 
> When the option is enabled, the kernel extracts the timestamp and copies
> it into the 'Time_Stamp' field of the outgoing HCI ISO packet.
> 
> This also gives the controller the reference timing information
> required for ISO stream synchronization.
> 
> A corresponding userspace change is required for full functionality.
> A reference implementation is available in PipeWire:
> https://gitlab.freedesktop.org/shitailu/pipewire/-/commit/5b3bd74e15febb974c8737a64f31fd17e18cd11b

Is the timestamp correctly visible in the btmon trace?

> Signed-off-by: tailu.shi <tailu.shi@samsung.com>
> ---
>   include/net/bluetooth/bluetooth.h |  5 ++++
>   include/net/bluetooth/hci_core.h  |  1 +
>   net/bluetooth/hci_core.c          |  2 +-
>   net/bluetooth/iso.c               | 49 +++++++++++++++++++++++++++----
>   4 files changed, 50 insertions(+), 7 deletions(-)
> 
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> index 69eed69f7f26..f88c83d21c5e 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -259,6 +259,10 @@ struct bt_codecs {
>   
>   #define BT_SCM_PKT_SEQNUM	0x05
>   
> +#define BT_PKT_ISO_TIMESTAMP     23
> +
> +#define BT_SCM_PKT_ISO_TIMESTAMP 0x06
> +
>   __printf(1, 2)
>   void bt_info(const char *fmt, ...);
>   __printf(1, 2)
> @@ -409,6 +413,7 @@ enum {
>   	BT_SK_SUSPEND,
>   	BT_SK_PKT_STATUS,
>   	BT_SK_PKT_SEQNUM,
> +	BT_SK_PKT_ISO_TIMESTAMP,
>   };
>   
>   struct bt_sock_list {
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index a7bffb908c1e..e39d192f8ef6 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -740,6 +740,7 @@ struct hci_conn {
>   	struct bt_iso_qos iso_qos;
>   	__u8		num_bis;
>   	__u8		bis[HCI_MAX_ISO_BIS];
> +	bool		iso_pkt_ts;
>   
>   	unsigned long	flags;
>   
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 31308c1de4ec..4264c0229dfb 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -3335,7 +3335,7 @@ static void hci_queue_iso(struct hci_conn *conn, struct sk_buff_head *queue,
>   
>   	list = skb_shinfo(skb)->frag_list;
>   
> -	flags = hci_iso_flags_pack(list ? ISO_START : ISO_SINGLE, 0x00);
> +	flags = hci_iso_flags_pack(list ? ISO_START : ISO_SINGLE, conn->iso_pkt_ts ? 0x01 : 0x00);
>   	hci_add_iso_hdr(skb, conn->handle, flags);
>   
>   	if (!list) {
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index be145e2736b7..dd4d198bab4c 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -73,6 +73,9 @@ struct iso_pinfo {
>   	__u8			base_len;
>   	__u8			base[BASE_MAX_LENGTH];
>   	struct iso_conn		*conn;
> +	bool			ts_flag;
> +	__u32			ts;
> +
>   };
>   
>   static struct bt_iso_qos default_qos;
> @@ -542,6 +545,7 @@ static int iso_send_frame(struct sock *sk, struct sk_buff *skb,
>   	struct iso_conn *conn = iso_pi(sk)->conn;
>   	struct bt_iso_qos *qos = iso_sock_get_qos(sk);
>   	struct hci_iso_data_hdr *hdr;
> +	struct hci_iso_ts_data_hdr *hdr_ts;
>   	int len = 0;
>   
>   	BT_DBG("sk %p len %d", sk, skb->len);
> @@ -552,13 +556,20 @@ static int iso_send_frame(struct sock *sk, struct sk_buff *skb,
>   	len = skb->len;
>   
>   	/* Push ISO data header */
> -	hdr = skb_push(skb, HCI_ISO_DATA_HDR_SIZE);
> -	hdr->sn = cpu_to_le16(conn->tx_sn++);
> -	hdr->slen = cpu_to_le16(hci_iso_data_len_pack(len,
> -						      HCI_ISO_STATUS_VALID));
> +	if (iso_pi(sk)->ts_flag) {
> +		hdr_ts = skb_push(skb, HCI_ISO_TS_DATA_HDR_SIZE);
> +		hdr_ts->ts = cpu_to_le32(iso_pi(sk)->ts);
> +		hdr_ts->sn = cpu_to_le16(conn->tx_sn++);
> +		hdr_ts->slen = cpu_to_le16(hci_iso_data_len_pack(len, HCI_ISO_STATUS_VALID));
> +	} else {
> +		hdr = skb_push(skb, HCI_ISO_DATA_HDR_SIZE);
> +		hdr->sn = cpu_to_le16(conn->tx_sn++);
> +		hdr->slen = cpu_to_le16(hci_iso_data_len_pack(len, HCI_ISO_STATUS_VALID));
> +	}
>   
>   	if (sk->sk_state == BT_CONNECTED) {
>   		hci_setup_tx_timestamp(skb, 1, sockc);
> +		conn->hcon->iso_pkt_ts = iso_pi(sk)->ts_flag;
>   		hci_send_iso(conn->hcon, skb);
>   	} else {
>   		len = -ENOTCONN;
> @@ -1471,7 +1482,8 @@ static int iso_sock_sendmsg(struct socket *sock, struct msghdr *msg,
>   	struct sock *sk = sock->sk;
>   	struct sk_buff *skb, **frag;
>   	struct sockcm_cookie sockc;
> -	size_t mtu;
> +	struct cmsghdr *cm;
> +	size_t mtu, hlen;
>   	int err;
>   
>   	BT_DBG("sock %p, sk %p", sock, sk);
> @@ -1485,10 +1497,23 @@ static int iso_sock_sendmsg(struct socket *sock, struct msghdr *msg,
>   
>   	hci_sockcm_init(&sockc, sk);
>   
> +	iso_pi(sk)->ts_flag = false;
>   	if (msg->msg_controllen) {
>   		err = sock_cmsg_send(sk, msg, &sockc);
>   		if (err)
>   			return err;
> +
> +		for (cm = CMSG_FIRSTHDR(msg); cm; cm = CMSG_NXTHDR(msg, cm)) {
> +			if (cm->cmsg_level != SOL_BLUETOOTH)
> +				continue;
> +			if (test_bit(BT_SK_PKT_ISO_TIMESTAMP, &bt_sk(sk)->flags) &&
> +			    cm->cmsg_type == BT_SCM_PKT_ISO_TIMESTAMP &&
> +			    cm->cmsg_len == CMSG_LEN(sizeof(u32))) {
> +				iso_pi(sk)->ts_flag = true;
> +				iso_pi(sk)->ts = *(u32 *)CMSG_DATA(cm);
> +				break;
> +			}
> +		}
>   	}
>   
>   	lock_sock(sk);
> @@ -1502,7 +1527,8 @@ static int iso_sock_sendmsg(struct socket *sock, struct msghdr *msg,
>   
>   	release_sock(sk);
>   
> -	skb = bt_skb_sendmsg(sk, msg, len, mtu, HCI_ISO_DATA_HDR_SIZE, 0);
> +	hlen = iso_pi(sk)->ts_flag ? HCI_ISO_TS_DATA_HDR_SIZE : HCI_ISO_DATA_HDR_SIZE;
> +	skb = bt_skb_sendmsg(sk, msg, len, mtu, hlen, 0);
>   	if (IS_ERR(skb))
>   		return PTR_ERR(skb);
>   
> @@ -1840,6 +1866,17 @@ static int iso_sock_setsockopt(struct socket *sock, int level, int optname,
>   
>   		break;
>   
> +	case BT_PKT_ISO_TIMESTAMP:
> +		err = copy_safe_from_sockptr(&opt, sizeof(opt), optval, optlen);
> +		if (err)
> +			break;
> +
> +		if (opt)
> +			set_bit(BT_SK_PKT_ISO_TIMESTAMP, &bt_sk(sk)->flags);
> +		else
> +			clear_bit(BT_SK_PKT_ISO_TIMESTAMP, &bt_sk(sk)->flags);
> +		break;
> +
>   	default:
>   		err = -ENOPROTOOPT;
>   		break;

The diff looks good.

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

