Return-Path: <netdev+bounces-239032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8CAC6283E
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 07:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3E0204E8E6D
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 06:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE8F314D38;
	Mon, 17 Nov 2025 06:28:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB6774BE1
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 06:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763360909; cv=none; b=J3N+q6d/9P+hqdu8d7aKwiRHqRbZ2wTu+BAJrFf67Un07n8K72f7zjURy++HOAFieBPDKjM07SOJ0QJNtAy1xO5+qRmmYfLOy1oyO8xHNumXFsgVsKhghH6rXWdd1p6FZm9QVauXiKfxgrzMVLs8lgZm8dn2sK2iq47vwwlzV/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763360909; c=relaxed/simple;
	bh=D0GZoq8M+/5IJnuA53jSoJ+A6kq82V7jQwlxj4J0Ph0=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=ggzbvHSeIkBcNIg47MI+ej91XcopPJYcj/2kKakmdhQfd6a30jNDmlcoJpmF5KE9Er2HOVM0pb3cMnVhzMV/ZZvvCS16bsSBmgBpNCV2nFSEo9P5+0Y0AxnXBcon4lulWj7JXZ/B2aS4AThKxjvNqCCBgy0q4vfS5grGl6P3+V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas9t1763360781t394t51185
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [125.120.152.51])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 17449204754345869829
To: "'Vadim Fedorenko'" <vadim.fedorenko@linux.dev>,
	<netdev@vger.kernel.org>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Russell King'" <linux@armlinux.org.uk>,
	"'Simon Horman'" <horms@kernel.org>,
	"'Jacob Keller'" <jacob.e.keller@intel.com>,
	<netdev@vger.kernel.org>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Russell King'" <linux@armlinux.org.uk>,
	"'Simon Horman'" <horms@kernel.org>,
	"'Jacob Keller'" <jacob.e.keller@intel.com>
Cc: "'Mengyuan Lou'" <mengyuanlou@net-swift.com>,
	"'Mengyuan Lou'" <mengyuanlou@net-swift.com>
References: <20251112055841.22984-1-jiawenwu@trustnetic.com> <20251112055841.22984-6-jiawenwu@trustnetic.com> <b7702efc-9994-4656-9d4e-29c2c8145ab3@linux.dev> <001401dc5444$3e897f60$bb9c7e20$@trustnetic.com> <4b9369f2-66fb-4c47-8bae-48577cf18c94@linux.dev>
In-Reply-To: <4b9369f2-66fb-4c47-8bae-48577cf18c94@linux.dev>
Subject: RE: [PATCH net-next 5/5] net: txgbe: support getting module EEPROM by page
Date: Mon, 17 Nov 2025 14:26:20 +0800
Message-ID: <012901dc578b$1683cf80$438b6e80$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQIM7yZFIqUFPQBkfWoGGA7engjSjgHLnukhAszbvKkDQik1TwGt0SqatEjxnoA=
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NojR6Ao/DkEDyHdsgqqYzbNCe5IfChfCH5oTj+pm7TRuSBYo40qdtwBj
	o8iR382r2jm7bLpjv3oHlqsQS820vU0GccoZYY2NEErdk2KgZvXNoSZWvwAr6Rul6CkAVAB
	GM/pfSVXNOnkvIorAI5nuUxDxquuC9+0lbwml3jbaWxsHGdk5IgHzmxuiC/vmzeDrJHCs4J
	Ou/x87hYMyIwH6ACA69m6O6vhDHnEmQawH8ivKhtf/zBjlOj8VIaqzhXepYdk66+hR/J+Oc
	Y0SZlh5ueJOiPkNsyhbJfp2bOAO6xmU26lrU+JOnSY/FgRDe9jHsp8oCbhaFJ2nu2xIqCBw
	dihYCTPP4dIeor4BpZh1Z8CpEGPj6mxUFVrk+n599d8alAhJYwaG0QwUCKryxUSoq0TH1id
	Eztq21KJeF4xXQkABsuE2ERSPI4Ql0kZAyHJ6zG49qqkwN7h5hY7tSAzBEan7cbHamMkByz
	HaEp42ovVX6NfLRHog9ni5aBulN+yoWOGj16ZIXB9tIAaBoXTQkj8VOXjQv5LU8bKjagRT8
	F81O06SEc8nPo1Orf4w4g7OdZCl9EEAfhOjjjgFjIEb4HX1WRIQxdSsWyYHX2fxNCuctBy2
	Xt4qBKBJIXQKPvpqjKqCv3/fboJBc0GILEHTA0eGz0nEWhkPLPIEIeecyzUdBsKXZyqKUW0
	gr1jIuJwEOz22RjKNkjznmhvc1uJYll932mucywpc7mT5nTBwIHQy4rT4w2sPFVOk9ti3J+
	t/twdLJaYYdCaFDr8Sm01Wk368dTmjk//qEsm0BblUHrRuNK3BmVp/F+tgrqXJPsIQH6DuG
	CVxh1PbpcyJCEJ0vHsZ6Q9ROv+E/ROMBqYU04GtW4xO7ccpMZn8/sTs5YkrQKB25pjsQtUt
	4CmM+EhQf0j7lV2duCkKjyQaM8VsgjHIeQIAxNSLosWD3VN+BeLyiw//8A8ZlZYT+l/P6W4
	BhVEhIRfOdmL6uVKqSOOImzzSu37DwfX9wO3PYTstaH6b/PKKL3Ndtv1n3bUOYZmbGK3oy1
	PUDiohFTTZMCmpwJDLgoDlUX65aX0E5WLCMEeRG7+vEvxFqUc9QTJ0E/ma5IU=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

> >>> +
> >>> +	for (i = 0; i < dword_len; i++) {
> >>> +		value = rd32a(wx, WX_FW2SW_MBOX, i);
> >>> +		le32_to_cpus(&value);
> >>> +
> >>> +		memcpy(&local_data[i * 4], &value, 4);
> >>> +	}
> >>
> >> the logic here is not clear from the first read of the code. effectively
> >> in the reply you have the same txgbe_hic_i2c_read struct but without
> >> data field, which is obviously VLA, but then you simply skip the result
> >> of read of txgbe_hic_i2c_read and only provide the real data back to the
> >> caller. Maybe you can organize the code the way it can avoid double copying?
> >
> > Because the length of real data is variable, now it could be 1 or 128. But the total
> > length of the command buffer is DWORD aligned. So we designed only a 1-byte
> > data field in struct txgbe_hic_i2c_read, to avoid redundant reading and writing
> > during the SW-FW interaction.
> >
> > For 1-byte data, wx_host_interface_command() can be used to set 'return_data'
> > to true, then page->data = buffer->data. For other cases, I think it would be more
> > convenient to read directly from the mailbox registers.
> 
> With such design you always have your return data starting at offset of
> 15, which is absolutely unaligned. And then it needs more buffer
> dancing.

OK. We could consider redesigning this buffer structure. Return data will start
at offset of 16, and reserve 4 bytes. And longer data will be directly read from
the mailbox register. Is this design more reasonable?



