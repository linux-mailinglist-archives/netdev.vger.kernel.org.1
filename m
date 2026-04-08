Return-Path: <netdev+bounces-276331-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKzRCcUH1mnbAQgAu9opvQ
	(envelope-from <netdev+bounces-276331-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 09:46:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7383B8832
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 09:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9800B30125CF
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 07:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A0E388E70;
	Wed,  8 Apr 2026 07:41:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27A9386541;
	Wed,  8 Apr 2026 07:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775634087; cv=none; b=gLqPW+gok9vH/+dIAqKY/sxgT991i4hUGylxdEHKrKflGracwl+qjHrnoOUBKenZCOSdXNYlO+MCJnmKkGBzXk4X878TENMo9TDujmkji7chCrAtq7k6QlXg/I77Dg6ebbeHdN+whf1lmYDIDu3ScudTts1neHSKEKdOFnCKe0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775634087; c=relaxed/simple;
	bh=P1YCk3GGzpy0RZbzaVHxVdbkM87LYN2ao5IVjXEwvGQ=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=kIKhEPVGpRjPpvLCazcOPZUJnab1TmKbQa3A3npyaByp9eezR+ZzCUXFdx2Wn9Fam2M/IScqsKYcY52cfemekJnjztfH1yGRCw+7HlYMCfQyr3YWXUumsAE9LTE2ZGTdV7SEFmdfEIFQQhefWsWDhYXjmjOL1OGARV6KAsz/3rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas9t1775634001t320t25977
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [115.220.225.134])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 5429651419727023235
To: "'Fabio Baltieri'" <fabio.baltieri@gmail.com>,
	"'Mengyuan Lou'" <mengyuanlou@net-swift.com>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Simon Horman'" <horms@kernel.org>,
	"'Mengyuan Lou'" <mengyuanlou@net-swift.com>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Simon Horman'" <horms@kernel.org>
Cc: <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260405222013.5347-1-fabio.baltieri@gmail.com>
In-Reply-To: <20260405222013.5347-1-fabio.baltieri@gmail.com>
Subject: RE: [PATCH] net: txgbe: leave space for null terminators on property_entry
Date: Wed, 8 Apr 2026 15:40:00 +0800
Message-ID: <09aa01dcc72a$e7bb2df0$b73189d0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQNkWyNE8BFpTjWSxK4kS4DkQDkby7LFnsTg
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NAeO0+xU6W76K8X+BNh0/wB4UxXm+/u5r5rq5o19Oq44Z4yL1EW6rsTQ
	DOJIXCl9JzkYoaBW0iNaOsmlEwiz4qAM/wgQocFsNVBRZ2XiLFCgQ862OPKvRpvzoE1LjTc
	KG5HEEtjWKg/bu/YvX5pejko1vAt55MTGDx6Sy2NMJDIx6VZT/CyZO4dPtltubz72MkwzMZ
	znyOjHthVByZ5M7UHYQpXsPKbwvaV41mfUoLGw9QCuvckSdRA3nSCMdxSYSk6EDE3Yg+hO3
	ftCZ+aW0VOJgjm2c9i4rPcWEZR3QoECnsrzQCgfcyiA4pb8OvlOJfUfHgddwlhjyT8ddF9Z
	/r+D3y/HwtYrtIQIDf0sAfR/+DqLAxawlo3IMRpwTIjgzJZzxjqv1ZUEzxrSwEGKIdLwJsy
	/HQZdwSWlyQjOn8AaEJ6bTPu0//xGB1kRGzUkI4SBHdwBAD9xh581CVzkNqh/sSIBbj4yg4
	FynUjc2pul4YTyuG1zZsvzb4EQfAJ2LeGQR65TtOsupykdBHT86aQXRuNo3ozKhUrnCHxgh
	B1FLr6hqF4/Zlz7mFou2Ddclu/+eSKhHPZIdcnm4S7qyCsD5cwEsDOEV8ZnkC1Ifs7hwn9e
	zPZmHlTo/eGDzIFoJGlwkFvh6EBA/WrI6baba76EyR2co+PjP3Qpu5gTVMd7Fh26Oql02dr
	/5/hpu5tTxeLH5tWLuusYhOvFcryBYfuvRCY4tg7t8MKKEw28t3S/nUzE0v4ZISs32BpXIQ
	qORuaGKQkrvgAYkZLnXcl+wy7bBJjt+WrKB7Q2lFTpz+WwpKX+j/fOObPlUIpM9ZFMRBUB5
	QGFgnvQVIxn2H1zTvpydZNDlmg/Ez40TmQyljcWzHINCX6on0ZJh6+AVCsCcvVzD6M+fKkB
	QTREyvZm8umk+gM1clCG9bR4GcyU2X4GzvIqCAdJX8i2vlf7iggP4t7aK321v+VhdHvc1D7
	c0DaTSKimh/trHK63U/Q09sUIAR+6+W3HmW5Ga0yPxMzjeS86d3BgBZgfkw+kjzcn/OFaV7
	FjGU9a0xbx+AFx5dRjJUWzOchzMr7SKcGBNUsxCdDNb0IxJA0H
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	FROM_EXCESS_BASE64(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DMARC_NA(0.00)[trustnetic.com];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-276331-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.789];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5A7383B8832
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Lists of struct property_entry are supposed to be terminated with an
> empty property, this driver currently seems to be allocating exactly the
> amount of entry used.
> 
> Change the struct definition to leave an extra element for all
> property_entry.
> 
> Signed-off-by: Fabio Baltieri <fabio.baltieri@gmail.com>
> ---
> 
> Hi, bumped into this while studying the code, looks like the struct has
> been allocated without space for terminators, guess the top ones just
> end up using the bottom props as well but I'm surprised this does not
> crash at some point. Build test only, don't have any hardware for this,
> let me know if I'm missing something here.
> 
> Cheers,
> Fabio
> 
>  drivers/net/ethernet/wangxun/txgbe/txgbe_type.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
> index 82433e9cb0e3..6b05f32b4a01 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
> @@ -424,10 +424,10 @@ struct txgbe_nodes {
>  	char i2c_name[32];
>  	char sfp_name[32];
>  	char phylink_name[32];
> -	struct property_entry gpio_props[1];
> -	struct property_entry i2c_props[3];
> -	struct property_entry sfp_props[8];
> -	struct property_entry phylink_props[2];
> +	struct property_entry gpio_props[2];
> +	struct property_entry i2c_props[4];
> +	struct property_entry sfp_props[9];
> +	struct property_entry phylink_props[3];
>  	struct software_node_ref_args i2c_ref[1];
>  	struct software_node_ref_args gpio0_ref[1];
>  	struct software_node_ref_args gpio1_ref[1];
> --
> 2.47.3

Tested-by: Jiawen Wu <jiawenwu@trustnetic.com>



