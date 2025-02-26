Return-Path: <netdev+bounces-169923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B126FA467B4
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 18:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6B88188A585
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 17:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7922253A9;
	Wed, 26 Feb 2025 17:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHfN+azv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED10225388;
	Wed, 26 Feb 2025 17:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740589930; cv=none; b=Br0PApZQO+nAJV0rnY0J0bQAHb/EnVDPkpQK6UVnQyvpsJZdXEiu8mBMS8bBAuzo2pEfk8QazzSS1Z3Wb2faW5Cq6VYiX1/468XME0ZSXB7lTF0m8Bl2YGG9Y5Jv7MDoyKc7TOosnrUDeMqumLy9co6M4qpZPOfnTcmQMojT2XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740589930; c=relaxed/simple;
	bh=bCFsSQk2TidtJIcQabLL//jFR8PWOOUExaamwCnHd/U=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=a1OZDFJs+LKZxX4CmUSZjdIEPvchpA/f3zaewbZn2DhRD3m3MagrmH/QEiF2aRT1x0cLXLxV48eOsHJOUFHIUAFC3fbgfvp+mILoaCK55xGWqM1Avbl5YtUw2V/O11if7rcbS+LySYdm8JRRFu13ZAegm9aIczhPsL7OdV9oN54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHfN+azv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FCEDC4CEFF;
	Wed, 26 Feb 2025 17:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740589929;
	bh=bCFsSQk2TidtJIcQabLL//jFR8PWOOUExaamwCnHd/U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dHfN+azv4iTM7t4HCjo5TdiYx2W9Qt4QVAkr4RIg+WgSKht2veBXhZ2WxaYxCw8Mn
	 d7PjK//WZFoA08BFizGZWqmP8bpY4mUVmk3oWGAo0WZImxIQPbu/UMEK71ze9QkRPG
	 UsBfrulQdP8Sw5jszB9gnwxpDRzPt4AKeA32vJUP2QOfiCedRZc4l4bZC5ZzaouUkH
	 Gya3V3gJr5OjCP1cS+oB7aRIf6ojECHCbIUUvPOeDt4PqU3UadBwBpEJHhEDA4SXZR
	 KSc7H7pifNpBxvWQT1aq8OHuKlat8147i8JnYSnt+pdWFeUEgYPTNm8/SbSWDJoPuj
	 0+1ANN9R/aTPQ==
Content-Type: multipart/mixed; boundary="------------VC1cxLU5U4YFqksw5cz0xkIc"
Message-ID: <7e148fd2-b4b7-49a1-958f-4b0838571245@kernel.org>
Date: Wed, 26 Feb 2025 10:12:08 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] trace: tcp: Add tracepoint for tcp_sendmsg()
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kernel-team@meta.com,
 yonghong.song@linux.dev
References: <20250224-tcpsendmsg-v1-1-bac043c59cc8@debian.org>
 <CANn89iLybqJ22LVy00KUOVscRr8GQ88AcJ3Oy9MjBUgN=or0jA@mail.gmail.com>
 <559f3da9-4b3d-41c2-bf44-18329f76e937@kernel.org>
 <20250226-cunning-innocent-degu-d6c2fe@leitao>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250226-cunning-innocent-degu-d6c2fe@leitao>

This is a multi-part message in MIME format.
--------------VC1cxLU5U4YFqksw5cz0xkIc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/26/25 9:10 AM, Breno Leitao wrote:
>> Also, if a tracepoint is added, inside of tcp_sendmsg_locked would cover
>> more use cases (see kernel references to it).
> 
> Agree, this seems to provide more useful information
> 
>> We have a patch for a couple years now with a tracepoint inside the
> 
> Sorry, where do you have this patch? is it downstream?

company tree. Attached. Where to put tracepoints and what arguments to
supply so that it is beneficial to multiple users is always a touchy
subject :-), so I have not tried to push the patch out. sock arg should
be added to it for example.

The key is to see how tcp_sendmsg_locked breaks up the buffers, and then
another one in tcp_write_xmit to see when the actual push out happens.
At the time I was looking at latency in the stack - from sendmsg call to
driver pushing descriptors to hardware.
--------------VC1cxLU5U4YFqksw5cz0xkIc
Content-Type: text/plain; charset=UTF-8;
 name="0001-tcp-Add-tracepoints-to-tcp_write_xmit-and-tcp_sendms.patch"
Content-Disposition: attachment;
 filename*0="0001-tcp-Add-tracepoints-to-tcp_write_xmit-and-tcp_sendms.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAyMjk4Y2E2NmMxNWJhZTZhOTU2OThhYmQ4ZDAyOWI5MjcxZmJlZmEzIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBEYXZpZCBBaGVybiA8ZHNhaGVybkBnbWFpbC5jb20+
CkRhdGU6IEZyaSwgMjQgTWFyIDIwMjMgMjI6MDc6NTMgKzAwMDAKU3ViamVjdDogW1BBVENI
XSB0Y3A6IEFkZCB0cmFjZXBvaW50cyB0byB0Y3Bfd3JpdGVfeG1pdCBhbmQgdGNwX3NlbmRt
c2dfbG9ja2VkCgpTaWduZWQtb2ZmLWJ5OiBEYXZpZCBBaGVybiA8ZHNhaGVybkBnbWFpbC5j
b20+Ci0tLQogaW5jbHVkZS90cmFjZS9ldmVudHMvdGNwLmggfCA1NyArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKwogbmV0L2lwdjQvdGNwLmMgICAgICAgICAgICAg
fCAgNCArKysKIG5ldC9pcHY0L3RjcF9vdXRwdXQuYyAgICAgIHwgIDEgKwogMyBmaWxlcyBj
aGFuZ2VkLCA2MiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS90cmFjZS9l
dmVudHMvdGNwLmggYi9pbmNsdWRlL3RyYWNlL2V2ZW50cy90Y3AuaAppbmRleCA5MDFiNDQw
MjM4ZDUuLjZiMTllMWQ0ZDc5ZCAxMDA2NDQKLS0tIGEvaW5jbHVkZS90cmFjZS9ldmVudHMv
dGNwLmgKKysrIGIvaW5jbHVkZS90cmFjZS9ldmVudHMvdGNwLmgKQEAgLTE4Nyw2ICsxODcs
NjMgQEAgREVGSU5FX0VWRU5UKHRjcF9ldmVudF9zaywgdGNwX3Jjdl9zcGFjZV9hZGp1c3Qs
CiAJVFBfQVJHUyhzaykKICk7CiAKK1RSQUNFX0VWRU5UKHRjcF9zZW5kbXNnX2xvY2tlZCwK
KworCVRQX1BST1RPKHN0cnVjdCBtc2doZHIgKm1zZywgc3RydWN0IHNrX2J1ZmYgKnNrYiwg
aW50IHNpemVfZ29hbCksCisKKwlUUF9BUkdTKG1zZywgc2tiLCBzaXplX2dvYWwpLAorCisJ
VFBfU1RSVUNUX19lbnRyeSgKKwkJX19maWVsZChfX3U2NCwgc2tiKQorCQlfX2ZpZWxkKGlu
dCwgc2tiX2xlbikKKwkJX19maWVsZChpbnQsIG1zZ19sZWZ0KQorCQlfX2ZpZWxkKGludCwg
c2l6ZV9nb2FsKQorCSksCisKKwlUUF9mYXN0X2Fzc2lnbigKKwkJX19lbnRyeS0+c2tiID0g
KF9fdTY0KXNrYjsKKwkJX19lbnRyeS0+c2tiX2xlbiA9IHNrYiA/IHNrYi0+bGVuIDogMDsK
KwkJX19lbnRyeS0+bXNnX2xlZnQgPSBtc2dfZGF0YV9sZWZ0KG1zZyk7CisJCV9fZW50cnkt
PnNpemVfZ29hbCA9IHNpemVfZ29hbDsKKwkpLAorCisJVFBfcHJpbnRrKCJza2IgJWxseCBs
ZW4gJWQgbXNnX2xlZnQgJWQgc2l6ZV9nb2FsICVkIiwKKwkJICBfX2VudHJ5LT5za2IsIF9f
ZW50cnktPnNrYl9sZW4sCisJCSAgX19lbnRyeS0+bXNnX2xlZnQsIF9fZW50cnktPnNpemVf
Z29hbCkKKyk7CisKK1RSQUNFX0VWRU5UKHRjcF93cml0ZV94bWl0LAorCisJVFBfUFJPVE8o
c3RydWN0IHNvY2sgKnNrLCB1bnNpZ25lZCBpbnQgbXNzX25vdywgaW50IG5vbmFnbGUsIHUz
MiBtYXhfc2VncyksCisKKwlUUF9BUkdTKHNrLCBtc3Nfbm93LCBub25hZ2xlLG1heF9zZWdz
KSwKKworCVRQX1NUUlVDVF9fZW50cnkoCisJCV9fZmllbGQoX191NjQsIHRjcF93c3RhbXBf
bnMpCisJCV9fZmllbGQoX191NjQsIHRjcF9jbG9ja19jYWNoZSkKKwkJX19maWVsZCh1bnNp
Z25lZCBpbnQsIG1zc19ub3cpCisJCV9fZmllbGQodW5zaWduZWQgaW50LCBtYXhfc2VncykK
KwkJX19maWVsZChpbnQsIG5vbmFnbGUpCisJCV9fZmllbGQoaW50LCBza19wYWNpbmcpCisJ
KSwKKworCVRQX2Zhc3RfYXNzaWduKAorCQlzdHJ1Y3QgdGNwX3NvY2sgKnRwID0gdGNwX3Nr
KHNrKTsKKworCQlfX2VudHJ5LT5tc3Nfbm93ICA9IG1zc19ub3c7CisJCV9fZW50cnktPm5v
bmFnbGUgID0gbm9uYWdsZTsKKwkJX19lbnRyeS0+bWF4X3NlZ3MgPSBtYXhfc2VnczsKKwkJ
X19lbnRyeS0+c2tfcGFjaW5nID0gdGNwX25lZWRzX2ludGVybmFsX3BhY2luZyhzayk7CisJ
CV9fZW50cnktPnRjcF93c3RhbXBfbnMgPSB0cC0+dGNwX3dzdGFtcF9uczsKKwkJX19lbnRy
eS0+dGNwX2Nsb2NrX2NhY2hlID0gdHAtPnRjcF9jbG9ja19jYWNoZTsKKwkpLAorCisJVFBf
cHJpbnRrKCJtc3MgJXUgc2VncyAldSBub25hZ2xlICVkIHNrX3BhY2luZyAlZCB0Y3Bfd3N0
YW1wX25zICVsbGQgdGNwX2Nsb2NrX2NhY2hlICVsbGQiLAorCQkgIF9fZW50cnktPm1zc19u
b3csIF9fZW50cnktPm1heF9zZWdzLAorCQkgIF9fZW50cnktPm5vbmFnbGUsIF9fZW50cnkt
PnNrX3BhY2luZywKKwkJICBfX2VudHJ5LT50Y3Bfd3N0YW1wX25zLCBfX2VudHJ5LT50Y3Bf
Y2xvY2tfY2FjaGUpCispOworCiBUUkFDRV9FVkVOVCh0Y3BfcmV0cmFuc21pdF9zeW5hY2ss
CiAKIAlUUF9QUk9UTyhjb25zdCBzdHJ1Y3Qgc29jayAqc2ssIGNvbnN0IHN0cnVjdCByZXF1
ZXN0X3NvY2sgKnJlcSksCmRpZmYgLS1naXQgYS9uZXQvaXB2NC90Y3AuYyBiL25ldC9pcHY0
L3RjcC5jCmluZGV4IDZiYjhlYjgwMzEwNS4uMGZhMmM4ZTAzNWI3IDEwMDY0NAotLS0gYS9u
ZXQvaXB2NC90Y3AuYworKysgYi9uZXQvaXB2NC90Y3AuYwpAQCAtMjc5LDYgKzI3OSw3IEBA
CiAjaW5jbHVkZSA8bGludXgvdWFjY2Vzcy5oPgogI2luY2x1ZGUgPGFzbS9pb2N0bHMuaD4K
ICNpbmNsdWRlIDxuZXQvYnVzeV9wb2xsLmg+CisjaW5jbHVkZSA8dHJhY2UvZXZlbnRzL3Rj
cC5oPgogCiAvKiBUcmFjayBwZW5kaW5nIENNU0dzLiAqLwogZW51bSB7CkBAIC0xMzEyLDYg
KzEzMTMsOCBAQCBpbnQgdGNwX3NlbmRtc2dfbG9ja2VkKHN0cnVjdCBzb2NrICpzaywgc3Ry
dWN0IG1zZ2hkciAqbXNnLCBzaXplX3Qgc2l6ZSkKIAkJaWYgKHNrYikKIAkJCWNvcHkgPSBz
aXplX2dvYWwgLSBza2ItPmxlbjsKIAorCQl0cmFjZV90Y3Bfc2VuZG1zZ19sb2NrZWQobXNn
LCBza2IsIHNpemVfZ29hbCk7CisKIAkJaWYgKGNvcHkgPD0gMCB8fCAhdGNwX3NrYl9jYW5f
Y29sbGFwc2VfdG8oc2tiKSkgewogCQkJYm9vbCBmaXJzdF9za2I7CiAKZGlmZiAtLWdpdCBh
L25ldC9pcHY0L3RjcF9vdXRwdXQuYyBiL25ldC9pcHY0L3RjcF9vdXRwdXQuYwppbmRleCA3
NDE5MDUxODcwOGEuLmM4NGYxOGNkOWI3ZSAxMDA2NDQKLS0tIGEvbmV0L2lwdjQvdGNwX291
dHB1dC5jCisrKyBiL25ldC9pcHY0L3RjcF9vdXRwdXQuYwpAQCAtMjYyMyw2ICsyNjIzLDcg
QEAgc3RhdGljIGJvb2wgdGNwX3dyaXRlX3htaXQoc3RydWN0IHNvY2sgKnNrLCB1bnNpZ25l
ZCBpbnQgbXNzX25vdywgaW50IG5vbmFnbGUsCiAJfQogCiAJbWF4X3NlZ3MgPSB0Y3BfdHNv
X3NlZ3Moc2ssIG1zc19ub3cpOworCXRyYWNlX3RjcF93cml0ZV94bWl0KHNrLCBtc3Nfbm93
LCBub25hZ2xlLCBtYXhfc2Vncyk7CiAJd2hpbGUgKChza2IgPSB0Y3Bfc2VuZF9oZWFkKHNr
KSkpIHsKIAkJdW5zaWduZWQgaW50IGxpbWl0OwogCi0tIAoyLjQzLjAKCg==

--------------VC1cxLU5U4YFqksw5cz0xkIc--

