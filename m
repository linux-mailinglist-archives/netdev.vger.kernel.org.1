Return-Path: <netdev+bounces-252598-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PlgI87YcmmqqAAAu9opvQ
	(envelope-from <netdev+bounces-252598-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 03:11:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 731566F77F
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 03:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0D50F300601C
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 02:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDBD35CB73;
	Fri, 23 Jan 2026 02:11:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (unknown [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB35361662;
	Fri, 23 Jan 2026 02:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769134279; cv=none; b=tH24GZv2M2kMwuT0/F9udRs3MGUvegdXtrvZL13VG0pxi4Z/RutVFtG+51Z7lVwtoGUpsb3KdBUyAZQGEYkz579/EGl7PrcdSO25dDdtg3rzORHs//rkIKqeH4PNElTfVPxvYUUhXm3paXMtBtlTyXCg1B1ivhHDmBF81K9BtCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769134279; c=relaxed/simple;
	bh=HDx61kISpf1zXDLGww25UQnMgNd7J99J/+C+MFVU6qI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aLmLRO5QLh6OwbJvltMaaRcZ2b3/Nva5RS8t+KesUuhjWgD8NOcCnejMdhHZOkMy7SaW1oi/x3XLsfecF1KZZ2USckabz6vxaJvWiNdDdxTYMUKuSwepLWjrZqckOmajm/aetCDSJJIQvQA7tCkPCUS8Zh4JLYTFGXXODaFtQD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [10.213.20.56] (unknown [210.73.43.101])
	by APP-01 (Coremail) with SMTP id qwCowADnkW2g2HJpLjjaBQ--.18034S2;
	Fri, 23 Jan 2026 10:10:42 +0800 (CST)
Message-ID: <c77a150a-4ad6-4765-9852-ce5e3408c29e@iscas.ac.cn>
Date: Fri, 23 Jan 2026 10:10:40 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] net: spacemit: display phy driver information
To: Andrew Lunn <andrew@lunn.ch>, Chukun Pan <amadeus@jmu.edu.cn>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, dlan@kernel.org,
 edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, netdev@vger.kernel.org, pabeni@redhat.com,
 spacemit@lists.linux.dev
References: <b4e0b1d2-cd6d-40f3-89fc-c1bd41c82480@lunn.ch>
 <20260122150601.586846-1-amadeus@jmu.edu.cn>
 <4493e09c-e4fb-424d-a44a-1e4d4510e4e2@lunn.ch>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <4493e09c-e4fb-424d-a44a-1e4d4510e4e2@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qwCowADnkW2g2HJpLjjaBQ--.18034S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtFW5Kr4rGrWrCw17Cw1rZwb_yoWDtFX_tF
	9Igwnxua1UXF4kJw1ayr43Zr9rt397Xr1rtay8JFWktr93JrZxWr4DZ34Sva48Wr42k3ZI
	kFnIvryrCry3ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbsAYjsxI4VWkKwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
	8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
	cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
	8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7
	MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7IU56yI5UUUUU==
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wangruikang@iscas.ac.cn,netdev@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252598-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[iscas.ac.cn];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 731566F77F
X-Rspamd-Action: no action

On 1/22/26 23:18, Andrew Lunn wrote:
> On Thu, Jan 22, 2026 at 11:06:01PM +0800, Chukun Pan wrote:
>> Hi,
>>
>>>> Print the PHY driver used and interrupt status after connection.
>>> The standard way to do this is call phy_attached_info(). Is it missing
>>> some information you need?
>> I initially used phy_attached_info(), but it was too long and printed
>> phydev_name() "cac80000.ethernet:01" twice:
>>
>> YT8531 Gigabit Ethernet cac80000.ethernet:01: attached PHY driver (mii_bus:phy_addr=cac80000.ethernet:01, irq=POLL)
> This is what everybody expects, so you should use it.
>
> You have some control over the names, it is the name you assign when
> creating the struct device. Maybe you can shorten them.

Right... it's just copied from the name of the platform device itself,
which is AFAICT a common approach.

Honestly I think the name doesn't need shortening. The K1 has two of
these MACs, so it needs the identifying information. And at least to me
the platform device name "cac80000.ethernet" is pretty recognizable.

Vivian "dramforever" Wang


