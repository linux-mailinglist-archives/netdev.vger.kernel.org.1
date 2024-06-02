Return-Path: <netdev+bounces-100011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B11978D7735
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 18:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B9C61F212A8
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 16:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2205E11712;
	Sun,  2 Jun 2024 16:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eMV20MTy"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDCA1DFF8;
	Sun,  2 Jun 2024 16:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717346729; cv=none; b=BiQ1yLUquaEkHoCSAc76icNvS+/YUs2lz8waxHEL0yjV4y9fb56uuyAbVgKabGBV4/0iF8YQL3RdGAdgQbnMqnPPUl4s1ztl/L7pVQaNiIPh34ueefZd8oMSWGbTBd2oR8nb+bsL3DeVRsEe9ko4bsi8a2nLEBBLsDba12+VM+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717346729; c=relaxed/simple;
	bh=c5LYpW+xTgQarazi/IQ7/kG9iiaYTqQFdkkLNpW95pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQwTWrX4Wfnn1qclyZ2AEZHmB90a+ejt1oiiBRCB/aVtt6NA7yQN70D5TYlbk6fDgB6H72cnFf/o9XjSuCoTKjpt8H5BlDKWvdJepZ16bHxQVGr6kRu4J0qVCoJtVKF0ZNI6fHDFqoCHy75QK3oM6LFN5YGBnd1G02bRNK6mjxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eMV20MTy; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=E+ueS2eEFa2OpuuO5ZI4AFvsqau7YjoMECLisKyw7Wk=; b=eMV20MTyZ4k3m5ti7s7PxT6V6f
	E4fWb4/PivFFAQ9A3x9BIRT/NiW9SWEh5zXBmzNLFqXnHZ1saDuqSnJ6E6gOpof8Gxg0GnJRZ8eVz
	LQw8iHtNIxVqU8W1lOWDpw3k4UM0zh3HNrlVI6cyXXnUkFIamHzBW40HIYhvei8Hkcy4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sDoKa-00Ge9U-Gf; Sun, 02 Jun 2024 18:45:16 +0200
Date: Sun, 2 Jun 2024 18:45:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yojana Mallik <y-mallik@ti.com>
Cc: schnelle@linux.ibm.com, wsa+renesas@sang-engineering.com,
	diogo.ivo@siemens.com, rdunlap@infradead.org, horms@kernel.org,
	vigneshr@ti.com, rogerq@ti.com, danishanwar@ti.com,
	pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, srk@ti.com, rogerq@kernel.org
Subject: Re: [PATCH net-next v2 2/3] net: ethernet: ti: Register the RPMsg
 driver as network device
Message-ID: <4416ada7-399b-4ea0-88b0-32ca432d777b@lunn.ch>
References: <20240531064006.1223417-1-y-mallik@ti.com>
 <20240531064006.1223417-3-y-mallik@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531064006.1223417-3-y-mallik@ti.com>

> +enum icve_rpmsg_type {
> +	/* Request types */
> +	ICVE_REQ_SHM_INFO = 0,
> +	ICVE_REQ_SET_MAC_ADDR,
> +
> +	/* Response types */
> +	ICVE_RESP_SHM_INFO,
> +	ICVE_RESP_SET_MAC_ADDR,
> +
> +	/* Notification types */
> +	ICVE_NOTIFY_PORT_UP,
> +	ICVE_NOTIFY_PORT_DOWN,
> +	ICVE_NOTIFY_PORT_READY,
> +	ICVE_NOTIFY_REMOTE_READY,
> +};

+struct message_header {
+       u32 src_id;
+       u32 msg_type; /* Do not use enum type, as enum size is compiler dependent */
+} __packed;


Given how you have defined icve_rpmsg_type, what is the point of
message_header.msg_type?

It seems like this would make more sense:

enum icve_rpmsg_request_type {
	ICVE_REQ_SHM_INFO = 0,
	ICVE_REQ_SET_MAC_ADDR,
}

enum icve_rpmsg_response_type {
	ICVE_RESP_SHM_INFO,
	ICVE_RESP_SET_MAC_ADDR,
}
enum icve_rpmsg_notify_type {
	ICVE_NOTIFY_PORT_UP,
	ICVE_NOTIFY_PORT_DOWN,
	ICVE_NOTIFY_PORT_READY,
	ICVE_NOTIFY_REMOTE_READY,
};

Also, why SET_MAC_ADDR? It would be good to document where the MAC
address are coming from. And what address this is setting.

In fact, please put all the protocol documentation into a .rst
file. That will help us discuss the protocol independent of the
implementation. The protocol is an ABI, so needs to be reviewed well.

> +struct icve_shm_info {
> +	/* Total shared memory size */
> +	u32 total_shm_size;
> +	/* Total number of buffers */
> +	u32 num_pkt_bufs;
> +	/* Per buff slot size i.e MTU Size + 4 bytes for magic number + 4 bytes
> +	 * for Pkt len
> +	 */

What is your definition of MTU?

enp2s0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc fq_codel state DOWN mode DEFAULT group default qlen 1000

Typically, MTU does not include the Ethernet header or checksum. Is
that what you mean here?

> +	u32 buff_slot_size;
> +	/* Base Address for Tx or Rx shared memory */
> +	u32 base_addr;
> +} __packed;

What do you mean by address here? Virtual address, physical address,
DMA address? And whos address is this, you have two CPUs here, with no
guaranteed the shared memory is mapped to the same address in both
address spaces.

	Andrew

