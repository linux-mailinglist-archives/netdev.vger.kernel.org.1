Return-Path: <netdev+bounces-289279-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAbwCCT6C2qISwUAu9opvQ
	(envelope-from <netdev+bounces-289279-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 07:50:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEF5577916
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 07:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 572B5302E7DA
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 05:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D1534D910;
	Tue, 19 May 2026 05:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="lx+LyYTD"
X-Original-To: netdev@vger.kernel.org
Received: from smtpcmd0757.aruba.it (smtpcmd0757.aruba.it [62.149.156.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111F534E754
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 05:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779169825; cv=none; b=lqgB95r0bEXbowg/U4MrnkauJwwrD6ZEoAfNK01E21Oyh6InHB1RyBREocnQixkVRtP7vJj2YhO13BacBxRy7Aw3u2Cu/yqfeRvx2G6VSMjEY12L0X37ggEhcEBEqtTBWJlZhR1HvD/nYm72+uVggAOeWTPqbQN9CJOmahQcNk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779169825; c=relaxed/simple;
	bh=xMYhnLP1MyfztVd2JPNtZqN8fFil7wNtyX0ygjFpAVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=otu8/5nqycr6OkS9YUDkPNWa1TZGxZS3zxf+eK5nIMZMlIin9jpqHqqKCqrgYU7Y388md+Jxgp8w9APHzWLkO/NUb5A/cZxBbEUcC29+wF7ZNirqFQc8+Q7Z/jWcFdX7YRB0YVCsVMc5OLJSqTxjIbuoy2vaRb0kGLDoCms8nIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=lx+LyYTD; arc=none smtp.client-ip=62.149.156.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from [192.168.0.186] ([109.118.84.223])
	by Aruba SMTP with ESMTPSA
	id PDIOwWh6TtpTfPDIOw0fNO; Tue, 19 May 2026 07:47:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1779169633; bh=xMYhnLP1MyfztVd2JPNtZqN8fFil7wNtyX0ygjFpAVY=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=lx+LyYTDZ+iy86irWou3Z+dZCA7yLnb6rE2yR8RP07UV6rTWrkcpG8PwjvhfFceg4
	 X7W2b50rdmfU1VZ7nE903iaMNeHlu6y48FQfkrpBTXm2fITM7Fb9KVEv3rkAattPaR
	 WA2H1iwXUh60uPJabRGo7sSRIDZBjJjWuRFoaKlUws4Kx7xsKG/95/Ad+ejgsQ3dtj
	 hGKvD8NXxpSc8x6eTTZItMCZH/Q5uUTlQq87qMwwLTC5M/YetlyomgDfdVffuUKQfL
	 hzMfbtml+qzPlIhB4EMUm4wMvzXDTLBa15mMr0NGnLahgckbehZ0EoIzCoWipa1Bho
	 9aosrOoQsKNWA==
Message-ID: <5a6bb963-1b5e-4e64-a65e-96cd7c69e9a4@enneenne.com>
Date: Tue, 19 May 2026 07:47:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] pps: bump PPS device count
Content-Language: en-US
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20260515135028.2021318-1-vadim.fedorenko@linux.dev>
From: Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <20260515135028.2021318-1-vadim.fedorenko@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfGxfjOQwufmhhgVVYHHW33xltufGUXoE4Bi2PmRr2RpINvXYrbwvIprYdk3saFWCEU5qHnAKWAHWwpuAkzFgMynu+gB4gnoZz4X7euco9/QxmmMYEIxn
 u9eGjN8j/35m3uB8KPnP7YmUZPzDhdDGuH3nJ2EdwhU4UqJE3BUK5QaA1R5WUpOyHtSAp4I/iF85jT1Cd0LlzZ2lg4V51z5p8j1g+D2rQz2xQg2KAmKVnRMM
 iEzYmvKzDBBDypbOwhQQIn3IGwy3j/XtVmIKp5fXZ3nAcu6YNNX0fAu4ZPT3nLaro3trVwyUMmGt7oYVdVLGCmG/JE2E3lP74wx8HHv35i3OXCLB2r+746Wf
 Qcsv8yQVpdptAdygaJxpCMQ1uIHoug==
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[aruba.it:s=a1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[enneenne.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,aruba.it:dkim];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[giometti@enneenne.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289279-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[aruba.it:+]
X-Rspamd-Queue-Id: 8AEF5577916
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/15/26 15:50, Vadim Fedorenko wrote:
> Modern systems may have more than 16 PPS sources and current hard-coded
> limit breaks registration of some devices. Let's bump the limit to 256
> in hope it will be enough in foreseen future.
> 
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

Acked-by: Rodolfo Giometti <giometti@enneenne.com>

> ---
>   include/uapi/linux/pps.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/pps.h b/include/uapi/linux/pps.h
> index 009ebcd8ced5..1088dea65e12 100644
> --- a/include/uapi/linux/pps.h
> +++ b/include/uapi/linux/pps.h
> @@ -26,7 +26,7 @@
>   #include <linux/types.h>
>   
>   #define PPS_VERSION		"5.3.6"
> -#define PPS_MAX_SOURCES		16		/* should be enough... */
> +#define PPS_MAX_SOURCES		256		/* should be enough... */
>   
>   /* Implementation note: the logical states ``assert'' and ``clear''
>    * are implemented in terms of the chip register, i.e. ``assert''


-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming

