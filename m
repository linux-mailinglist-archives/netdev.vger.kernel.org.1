Return-Path: <netdev+bounces-252586-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJrNB3rPcmnKpgAAu9opvQ
	(envelope-from <netdev+bounces-252586-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 02:31:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 897EF6F18F
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 02:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 441AA3012CCB
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 01:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506AD37B41A;
	Fri, 23 Jan 2026 01:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tp27LJUC"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0E634C139;
	Fri, 23 Jan 2026 01:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769131889; cv=none; b=N6KCtnxsc+0EpeKsSzY+cTv6cEKbdxhlKS4OJJMhTLnjCQKlsJr16jZPnDHraLob2CZ7XLgDL423y0KLVyfH/HJ0HZpf8PMm2dQLLA0XXCv1ZZNReFyGSZgRnxQ1xgKZ7HMa69YYyAJ5YY8zj3RqfJc0iPfDgTzGyGlJjmycUV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769131889; c=relaxed/simple;
	bh=uf2rPNDQsmJEOmZ2YblpI/30vW4Z5pDMGgD1be4YNuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=krIB+9UYR+ZabS1h08fmNwOqafvd6JOhJ6vUg7Uxu+Utw78JnANgCrw2ZvG2z2iMLu8NikADBYSbdid5tNn/4YJyrq68JcbVrFHyIzS+C4NYx2IljmqBuBnBG6Vys1wXPUtc64SJqSepnyAnIM03m+jFHE3qp99+bmNzCEMohz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tp27LJUC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=ix06gVywB2waC2wNUzplaOuqmAokM10i9mmzizx8WsE=; b=tp27LJUCWmFr32FOkvqbW0ca/f
	DGKltpqaLWOM1w58J9+bIB7d9AGiXkE8xFyhoVeolPMntqIuViRP2+mcviilQdNyaNTLTBabUpR/O
	9Zr48HvFWGLbqCAn7QRkmKwPFTbZLNRssHmLXcuyLU+sF80LLYOIVCL5+vgTadbejBHwWITP3Oc+u
	n4k/ithyDnhHQgY6my3OVseeekVJuCTujgfQzbc/qvzSPWdbRFSgHmN4bvfDHjTcPlzr/+Lvgmwt8
	1KgCEJVFTEIrsxR84m9YZNCIsBPKTMKzmdhN+Fvl2bEqzaDWG9uuK0H8HmZ/Lqw5M/Wmk6s1b6lfK
	h/orXbhQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vj617-00000007y4S-3Efz;
	Fri, 23 Jan 2026 01:31:17 +0000
Message-ID: <9026b5ab-c796-44c9-9b18-0e020e5c4397@infradead.org>
Date: Thu, 22 Jan 2026 17:31:16 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 01/15] net/nebula-matrix: add minimum nbl
 build framework
To: "illusion.wang" <illusion.wang@nebula-matrix.com>,
 dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, corbet@lwn.net, kuba@kernel.org,
 linux-doc@vger.kernel.org, lorenzo@kernel.org, pabeni@redhat.com,
 horms@kernel.org, vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com,
 hawk@kernel.org, ast@kernel.org, bpf@vger.kernel.org, sdf@fomichev.me,
 daniel@iogearbox.net, john.fastabend@gmail.com, edumazet@google.com,
 open list <linux-kernel@vger.kernel.org>
References: <20260123011804.31263-1-illusion.wang@nebula-matrix.com>
 <20260123011804.31263-2-illusion.wang@nebula-matrix.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260123011804.31263-2-illusion.wang@nebula-matrix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252586-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,lwn.net,kernel.org,vger.kernel.org,redhat.com,linux.dev,fomichev.me,iogearbox.net,gmail.com,google.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rdunlap@infradead.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nebula-matrix.com:url,illusion.wang:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:mid,infradead.org:dkim]
X-Rspamd-Queue-Id: 897EF6F18F
X-Rspamd-Action: no action

Hi--

On 1/22/26 5:17 PM, illusion.wang wrote:
> diff --git a/drivers/net/ethernet/nebula-matrix/Kconfig b/drivers/net/ethernet/nebula-matrix/Kconfig
> new file mode 100644
> index 000000000000..14c27c63d7ec
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/Kconfig
> @@ -0,0 +1,37 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Nebula-matrix network device configuration
> +#
> +
> +config NET_VENDOR_NEBULA_MATRIX
> +    bool "Nebula-matrix devices"
> +    default y
> +    help
> +      If you have a network (Ethernet) card belonging to this class, say Y.
> +
> +      Note that the answer to this question doesn't directly affect the
> +      kernel: saying N will just cause the configurator to skip all
> +      the questions about Nebula-matrix cards. If you say Y, you will be
> +      asked for your specific card in the following questions.
> +
> +if NET_VENDOR_NEBULA_MATRIX
> +
> +config NBL_CORE
> +    tristate "Nebula-matrix Ethernet Controller m18100 Family support"
> +    depends on 64BIT && PCI
> +    default m
> +    select PAGE_POOL
> +    help
> +      This driver supports Nebula-matrix Ethernet Controller m18100 Family of
> +      devices.  For more information about this product, go to the product
> +      description with smart NIC:
> +
> +      <http://www.nebula-matrix.com>
> +
> +      More specific information on configuring the driver is in
> +      <file:Documentation/networking/device_drivers/ethernet/nebula-matrix/m18100.rst>.
> +
> +      To compile this driver as a module, choose M here. The module
> +      will be called nbl_core.
> +
> +endif # NET_VENDOR_NEBULA_MATRIX

There are lots of spaces used here for indentation.

Please see Documentation/process/coding-style.rst, section
10) Kconfig configuration files, for the correct indentation style
for Kconfig files.


-- 
~Randy


