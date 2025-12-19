Return-Path: <netdev+bounces-245464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AF9CCE434
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 03:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4058B3021E50
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 02:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF2129346F;
	Fri, 19 Dec 2025 02:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pfdhPPqH"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2526521D3F2;
	Fri, 19 Dec 2025 02:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766111250; cv=none; b=Imald8phFfaQ+J1fP9Yr7Wc4URgXeETcgujXGAh3+TDcdoE0GUDCR5b5EJIKLu/FwZ4MRGZ7WM1g2y8kuI+zkDVk1fJhiZtgFeCEEi4PvjRJI3QUTsux4iWwPE8gWf0kyJ4PDtVHyJSse8i68wkTBnrMn5atFcbApM8I+CCfAbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766111250; c=relaxed/simple;
	bh=hpVinBMNimQMwx05vx2WnvYPhGGgB4dldTnAWfMNBiY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=QkncpXEQzwhM5sdUvMZe1Khaa5fO/1ImDRX4zEuDeh7eqQteaikyxzZ1bP/LIAtHNzxvqfsqg6d+NjS6NEAzw1JmVSE2WEMCSZA5UyxW9dUF9KxtO1DMRrJzYII0+DAKackzZn9BmOBNQISVgC9cMK6ZsU5TfjoKSN9Q5RzEJ5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pfdhPPqH; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=hpVinBMNimQMwx05vx2WnvYPhGGgB4dldTnAWfMNBiY=; b=p
	fdhPPqHFVNwkIWb3TctiLcvc9Gm/HIdU1J2jq0L+vojjZAeHLeKc4tc9THQ5LCxe
	Zgj39TBxOle2Zk5gkuHVkkeiYhgf9gX6jdwjCOTKfUKPJc14c86vR2D2Va/x3Kfm
	MiTtQhCpNK8w0NN8yvq1DwK/X7YkcAbEqLAemIXnY8=
Received: from 15927021679$163.com ( [116.128.244.169] ) by
 ajax-webmail-wmsvr-40-107 (Coremail) ; Fri, 19 Dec 2025 10:26:41 +0800
 (CST)
Date: Fri, 19 Dec 2025 10:26:41 +0800 (CST)
From: =?UTF-8?B?54aK5Lyf5rCRICA=?= <15927021679@163.com>
To: "Leon Romanovsky" <leon@kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>,
	"David S . Miller" <davem@davemloft.net>,
	"Jakub Kicinski" <kuba@kernel.org>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>,
	"John Fastabend" <john.fastabend@gmail.com>,
	"Stanislav Fomichev" <sdf@fomichev.me>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re:Re: Implement initial driver for virtio-RDMA devices(kernel),
 virtio-rdma device model(qemu) and vhost-user-RDMA backend device(dpdk)
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20250723(a044bf12) Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <20251218162028.GG400630@unreal>
References: <20251217085044.5432-1-15927021679@163.com>
 <20251218162028.GG400630@unreal>
X-NTES-SC: AL_Qu2dBP2avkor5yWebOkfmU0VgOc9XsWwu/Uk2YRXc+AEvhn91i0NcGBfB13x3/C3Cw2orgSHdD9v4+NFc5ZjKLN3v7mXibZMNFWZYsPrwQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <4701065a.4aa9.19b346e492d.Coremail.15927021679@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:aygvCgDHIxfit0RplcU_AA--.11618W
X-CM-SenderInfo: jprvmjixqsilmxzbiqqrwthudrp/xtbC0QKRGmlEt+JZuQAA3A
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

QXQgMjAyNS0xMi0xOSAwMDoyMDoyOCwgIkxlb24gUm9tYW5vdnNreSIgPGxlb25Aa2VybmVsLm9y
Zz4gd3JvdGU6Cj5PbiBXZWQsIERlYyAxNywgMjAyNSBhdCAwNDo0OTo0N1BNICswODAwLCBYaW9u
ZyBXZWltaW4gd3JvdGU6Cj4+IEhpIGFsbCwKPj4gCj4+IFRoaXMgdGVzdGluZyBpbnN0cnVjdGlv
bnMgYWltcyB0byBpbnRyb2R1Y2UgYW4gZW11bGF0aW5nIGEgc29mdCBST0NFIAo+PiBkZXZpY2Ug
d2l0aCBub3JtYWwgTklDKG5vIFJETUEpLgo+Cj5XaGF0IGlzIGl0PyBXZSBhbHJlYWR5IGhhdmUg
b25lIHNvZnQgUm9DRSBkZXZpY2UgaW1wbGVtZW50ZWQgaW4gdGhlCj5rZXJuZWwgKGRyaXZlcnMv
aW5maW5pYmFuZC9zdy9yeGUpLCB3aGljaCBkb2Vzbid0IHJlcXVpcmUgYW55IFFFTVUKPmNoYW5n
ZXMgYXQgYWxsLgo+Cgo+VGhhbmtzCj4KVGhlIGZyYW13b3JrIG9mIHZob3N0X3VzZXJfcmRtYShk
cGRrKS92aXJ0aW8tcmRtYSBkcml2ZXIoa2VybmVsKSBpcyBhY3R1YWxseSAKYSB1c2Vyc3BhY2Ug
UkRNQSBiYWNrZW5kIG9wdGltaXplZCBmb3IgdmlydHVhbGl6YXRpb24sIHdoaWxlIHJ4ZSAoU29m
dC1Sb0NFKSAKaXMgYSBrZXJuZWwtYmFzZWQgc29mdHdhcmUgUkRNQSBpbXBsZW1lbnRhdGlvbi4g
S2V5IGFkdmFudGFnZXMgaW5jbHVkZToKMS7CoFplcm8tQ29weSBBcmNoaXRlY3R1cmU6wqB2aG9z
dF91c2VyX3JkbWEgdXNlcyBzaGFyZWQgbWVtb3J5IGJldHdlZW4gVk1zIGFuZCAKaG9zdCBwcm9j
ZXNzZXMswqBlbGltaW5hdGluZyBkYXRhIGNvcGllcy5yeGUgcmVxdWlyZXMga2VybmVsLW1lZGlh
dGVkIGRhdGEgY29waWVzLCAKYWRkaW5nIGxhdGVuY3kuCgoKMi4gUG9sbGluZyBNb2RlOsKgQXZv
aWRzIFZNLUV4aXQgaW50ZXJydXB0cyBieSB1c2luZyBidXN5LXdhaXQgcG9sbGluZywgcmVkdWNp
bmcgCkNQVSBjb250ZXh0IHN3aXRjaGVzLgoKCjMuIFFFTVUvS1ZNIE5hdGl2ZSBTdXBwb3J0OiB2
aG9zdF91c2VyX3JkbWEgaW50ZWdyYXRlcyBkaXJlY3RseSB3aXRoIGh5cGVydmlzb3JzIAp2aWEg
dmhvc3QtdXNlciBwcm90b2NvbC5yeGUgcmVxdWlyZXMgUENJIGRldmljZSBwYXNzdGhyb3VnaCAo
IGUuZy4sIFZGSU8pLCAKY29tcGxpY2F0aW5nIGRlcGxveW1lbnQuCgoKNC4gRmVhdHVyZXMgU3Vw
cG9ydDogdmhvc3RfdXNlcl9yZG1hIGVuYWJsZXMgbGl2ZSBtaWdyYXRpb24sIG11bHRpLXF1ZXVl
IHZpcnRpbywgCmFuZCBOVU1BLWF3YXJlIEkvTyBwcm9jZXNzaW5nLgoKCjUuIFVzZXJzcGFjZSBQ
cm9jZXNzaW5nOiBPcGVyYXRlcyBlbnRpcmVseSBpbiB1c2Vyc3BhY2UgKCBlLmcuLCB3aXRoIFNQ
REspLCBieXBhc3NpbmcKdGhlIGtlcm5lbCBuZXR3b3JrIHN0YWNrLiByeGUgcmVsaWVzIG9uIHRo
ZSBMaW51eCBrZXJuZWwgbmV0d29yayBzdGFjaywgY29uc3VtaW5nIG1vcmUgCkNQVSByZXNvdXJj
ZXMuCgoKNi4gUmVzb3VyY2UgRWZmaWNpZW5jeTogQWNoaWV2ZXMgbG93ZXIgbGF0ZW5jeSBpbiBi
ZW5jaG1hcmtzIGZvciBWTS10by1WTSBjb21tdW5pY2F0aW9uLiAKCgo3LiB2aG9zdC11c2VyIEJh
Y2tlbmQ6IERQREsgcHJvdmlkZXMgYSB2aG9zdC11c2VyIGxpYnJhcnkgdGhhdCBpbXBsZW1lbnRz
IHRoZSB2aG9zdC11c2VyIApwcm90b2NvbCBpbiB1c2Vyc3BhY2UuIFRoaXMgbGlicmFyeSBlbmFi
bGVzIGVmZmljaWVudCBjb21tdW5pY2F0aW9uIGJldHdlZW4gdGhlIGh5cGVydmlzb3IgCihRRU1V
KSBhbmQgdGhlIHVzZXJzcGFjZSBuZXR3b3JraW5nIHN0YWNrIChsaWtlIGEgRFBESy1iYXNlZCBh
cHBsaWNhdGlvbikuIEZvciBSRE1BLCB0aGlzIAptZWFucyB0aGF0IHRoZSB2aG9zdC11c2VyIGJh
Y2tlbmQgY2FuIGRpcmVjdGx5IGhhbmRsZSBSRE1BIG9wZXJhdGlvbnMgd2l0aG91dCBnb2luZyB0
aHJvdWdoIAp0aGUga2VybmVsLgoKClRoYW5rcyAKCgoKCgoKCg==

