Return-Path: <netdev+bounces-293381-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uL9fAHTeG2psGwkAu9opvQ
	(envelope-from <netdev+bounces-293381-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 09:08:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7B9614C8A
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 09:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2F1C3302C346
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 07:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1309D32ED4E;
	Sun, 31 May 2026 07:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9lhfOgB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1531FC7;
	Sun, 31 May 2026 07:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780211313; cv=none; b=GOxDaiVPqJOJSn7pTLWvMcTBr85/6MB+HIl0XGQ1IUcRTVCcRU8qcAGgOt0jYet+5ABZgT4bl559GLxMtafKS3XMiTBiKkbhzxZu1RqwoWeG9Df1g95oVessb3qDpXRHHbjt9n5mQk1Gc3i68pInWbuLd0u89i/Zo0EjnCGiHrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780211313; c=relaxed/simple;
	bh=EzMeocWO/CpBHA8mry1WVpWnhmjsCPC+YkaexLZ8Ro8=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=KPMNpHLQyJLIHZqk68ozyL1Lcndz5/QjktdohKV6jQ5xjQ+zoZIrft1ZXmA5Vf3osQsSi/5VgiJRyFJL6eo+6xDQsc66a6K+yBT7+ENUA/8g2MUs0sM3G9umqO3GgIbysCP6w6fWRwM75IdYFAjXRw0QX3HHgLm8qDc+uBYPrQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9lhfOgB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07881F00893;
	Sun, 31 May 2026 07:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780211311;
	bh=Mkay01Z2n0ezQgLvc+M44egscys/ifvsolvgsvp7K/o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=k9lhfOgBNn5xrghKu1QN7BVFy2cu49UK6N96pb3hwY/e2TmfYZZTJU1v0dniyXPqx
	 igyQtCqwmDwCinFuy5es1nhMiSRYU0/x5bWNzktxEIIFLQuq/9ntrG2nMR/za2qYU1
	 7QYtGDawszFnR1HagetW5bQmt5efnS7ptu6KkF+5nScN+omQxWcVOql2E4osj97J0X
	 G1khV472sKju3TAeb+sU5SCkCDhTKJ2mMP9Z4k67Ege8EZQTeTYkt5QrKn7pzbXuyM
	 nrV5Na91ZL9sH6D7T3bTphaeaar+Vn/rXtuqgL4u1yzsB+d0rqDyAGQwbzGHFbCM0C
	 TlLHRJXCVmcPw==
Content-Type: multipart/mixed; boundary="------------NvOiUTJng2reEtxZT0zj42gT"
Message-ID: <a57a1700-52f4-43ea-b341-801daf7dc3aa@kernel.org>
Date: Sun, 31 May 2026 17:08:24 +1000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: linux-next: manual merge of the net-next tree with the net tree
Content-Language: fr
To: Mark Brown <broonie@kernel.org>
Cc: Aditya Garg <gargaditya@linux.microsoft.com>,
 Dipayaan Roy <dipayanroy@linux.microsoft.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Networking <netdev@vger.kernel.org>
References: <ahoDdhD_o5iVnr44@sirena.org.uk>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <ahoDdhD_o5iVnr44@sirena.org.uk>
X-Spamd-Result: default: False [-1.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293381-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6A7B9614C8A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is a multi-part message in MIME format.
--------------NvOiUTJng2reEtxZT0zj42gT
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mark,

On 30/05/2026 07:21, Mark Brown wrote:
> Hi all,
> 
> Today's linux-next merge of the net-next tree got a conflict in:
> 
>   drivers/net/ethernet/microsoft/mana/mana_en.c
> 
> between commit:
> 
>   17bfe0a8c014e ("net: mana: Add NULL guards in teardown path to prevent panic on attach failure")
> 
> from the net tree and commit:
> 
>   d07efe5a6e641 ("net: mana: Use per-queue allocation for tx_qp to reduce allocation size")
> 
> from the net-next tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Thank you for the fix! I also had the conflict on my side, but I noticed
a small issue with your resolution, please see below:

> diff --combined drivers/net/ethernet/microsoft/mana/mana_en.c
> index cc48cd06cb15d,c9b1df1ed1098..0000000000000
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c

(...)

> @@@ -3338,21 -3296,13 +3338,21 @@@ static int mana_dealloc_queues(struct n
>   
>   	if (apc->tx_qp) {
>   		for (i = 0; i < apc->num_queues; i++) {
>  -			txq = &apc->tx_qp[i].txq;
>  +			txq = &apc->tx_qp[i]->txq;
>   			tsleep = 1000;
>   			while (atomic_read(&txq->pending_sends) > 0 &&
>   			       time_before(jiffies, timeout)) {
>   				usleep_range(tsleep, tsleep + 1000);
>   				tsleep <<= 1;
>   			}
>  +			if (atomic_read(&txq->pending_sends)) {
>  +				err = pcie_flr(to_pci_dev(gd->gdma_context->dev));
>  +				if (err) {
>  +					netdev_err(ndev, "flr failed %d with %d pkts pending in txq %u\n",
>  +						   err, atomic_read(&txq->pending_sends),
>  +						   txq->gdma_txq_id);
>  +				}
>  +			}

I don't think you should add this block here, it was already present
below, but slightly different:

 - with 'err =' on a single line
 - netdev_err()'s parameters have a different indentation
 - with a 'break' at the end

In other words, please drop this block here above :)

Just in case, I attached the generated patch, and rerere cache are
available there:

https://github.com/multipath-tcp/mptcp-upstream-rr-cache/commit/29ad33b

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

--------------NvOiUTJng2reEtxZT0zj42gT
Content-Type: text/x-patch; charset=UTF-8;
 name="3a52437490681fa66d4330c4c1f4a44edaf94b47.patch"
Content-Disposition: attachment;
 filename="3a52437490681fa66d4330c4c1f4a44edaf94b47.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWNjIGRyaXZlcnMvbmV0L2V0aGVybmV0L21pY3Jvc29mdC9tYW5hL21hbmFfZW4u
YwppbmRleCA4MmYxNDYxYTQ4ZTksYzliMWRmMWVkMTA5Li4yYzY0MDJkYmE1YmIKLS0tIGEv
ZHJpdmVycy9uZXQvZXRoZXJuZXQvbWljcm9zb2Z0L21hbmEvbWFuYV9lbi5jCisrKyBiL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L21pY3Jvc29mdC9tYW5hL21hbmFfZW4uYwpAQEAgLTMzMjks
MjIgLTMyOTQsMzUgKzMzMzYsMzUgQEBAIHN0YXRpYyBpbnQgbWFuYV9kZWFsbG9jX3F1ZXVl
cyhzdHJ1Y3QgbgogIAkgKiBudW1iZXIgb2YgcXVldWVzLgogIAkgKi8KICAKLSAJZm9yIChp
ID0gMDsgaSA8IGFwYy0+bnVtX3F1ZXVlczsgaSsrKSB7Ci0gCQl0eHEgPSAmYXBjLT50eF9x
cFtpXS0+dHhxOwotIAkJdHNsZWVwID0gMTAwMDsKLSAJCXdoaWxlIChhdG9taWNfcmVhZCgm
dHhxLT5wZW5kaW5nX3NlbmRzKSA+IDAgJiYKLSAJCSAgICAgICB0aW1lX2JlZm9yZShqaWZm
aWVzLCB0aW1lb3V0KSkgewotIAkJCXVzbGVlcF9yYW5nZSh0c2xlZXAsIHRzbGVlcCArIDEw
MDApOwotIAkJCXRzbGVlcCA8PD0gMTsKLSAJCX0KLSAJCWlmIChhdG9taWNfcmVhZCgmdHhx
LT5wZW5kaW5nX3NlbmRzKSkgewotIAkJCWVyciA9IHBjaWVfZmxyKHRvX3BjaV9kZXYoZ2Qt
PmdkbWFfY29udGV4dC0+ZGV2KSk7Ci0gCQkJaWYgKGVycikgewotIAkJCQluZXRkZXZfZXJy
KG5kZXYsICJmbHIgZmFpbGVkICVkIHdpdGggJWQgcGt0cyBwZW5kaW5nIGluIHR4cSAldVxu
IiwKLSAJCQkJCSAgIGVyciwgYXRvbWljX3JlYWQoJnR4cS0+cGVuZGluZ19zZW5kcyksCi0g
CQkJCQkgICB0eHEtPmdkbWFfdHhxX2lkKTsKKyAJaWYgKGFwYy0+dHhfcXApIHsKKyAJCWZv
ciAoaSA9IDA7IGkgPCBhcGMtPm51bV9xdWV1ZXM7IGkrKykgewogLQkJCXR4cSA9ICZhcGMt
PnR4X3FwW2ldLnR4cTsKKysJCQl0eHEgPSAmYXBjLT50eF9xcFtpXS0+dHhxOworIAkJCXRz
bGVlcCA9IDEwMDA7CisgCQkJd2hpbGUgKGF0b21pY19yZWFkKCZ0eHEtPnBlbmRpbmdfc2Vu
ZHMpID4gMCAmJgorIAkJCSAgICAgICB0aW1lX2JlZm9yZShqaWZmaWVzLCB0aW1lb3V0KSkg
eworIAkJCQl1c2xlZXBfcmFuZ2UodHNsZWVwLCB0c2xlZXAgKyAxMDAwKTsKKyAJCQkJdHNs
ZWVwIDw8PSAxOwogIAkJCX0KLSAJCQlicmVhazsKKyAJCQlpZiAoYXRvbWljX3JlYWQoJnR4
cS0+cGVuZGluZ19zZW5kcykpIHsKKyAJCQkJZXJyID0KKyAJCQkJICAgIHBjaWVfZmxyKHRv
X3BjaV9kZXYoZ2QtPmdkbWFfY29udGV4dC0+ZGV2KSk7CisgCQkJCWlmIChlcnIpIHsKKyAJ
CQkJCW5ldGRldl9lcnIobmRldiwgImZsciBmYWlsZWQgJWQgd2l0aCAlZCBwa3RzIHBlbmRp
bmcgaW4gdHhxICV1XG4iLAorIAkJCQkJCSAgIGVyciwKKyAJCQkJCSAgICBhdG9taWNfcmVh
ZCgmdHhxLT5wZW5kaW5nX3NlbmRzKSwKKyAJCQkJCSAgICB0eHEtPmdkbWFfdHhxX2lkKTsK
KyAJCQkJfQorIAkJCQlicmVhazsKKyAJCQl9CisgCQl9CisgCisgCQlmb3IgKGkgPSAwOyBp
IDwgYXBjLT5udW1fcXVldWVzOyBpKyspIHsKKyAJCQl0eHEgPSAmYXBjLT50eF9xcFtpXS50
eHE7CisgCQkJd2hpbGUgKChza2IgPSBza2JfZGVxdWV1ZSgmdHhxLT5wZW5kaW5nX3NrYnMp
KSkgeworIAkJCQltYW5hX3VubWFwX3NrYihza2IsIGFwYyk7CisgCQkJCWRldl9rZnJlZV9z
a2JfYW55KHNrYik7CisgCQkJfQorIAkJCWF0b21pY19zZXQoJnR4cS0+cGVuZGluZ19zZW5k
cywgMCk7CiAgCQl9CiAgCX0KICAK

--------------NvOiUTJng2reEtxZT0zj42gT--

