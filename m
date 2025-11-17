Return-Path: <netdev+bounces-239022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A713AC627CE
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 07:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2619E4E65D8
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 06:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C7A30F95C;
	Mon, 17 Nov 2025 06:14:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC6328695
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 06:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763360083; cv=none; b=RfWCMpSa76TojLbcfIKW2MVO/jgYqI5LYiSMxgx5x6sqBMlBdNNiud6OYE0gJ0BH+FxCi8+EdAzsro5kxROSGoWqojXkzf+2qoCUHcHMXp0NRJtM9hvXNXs1qL4/udz+l2ggxpudGybzC9ztHmY4anjHzi23+6HLFnh6UhGoVKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763360083; c=relaxed/simple;
	bh=4agCmcXpYxMBHHl5QUK6ZxgX0C1+K8nZA6TLFHrMHbw=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=TSoDKkC2nKDwbAhjs0yhUcHWnHHUEN4T3CnQ0kY4YiDHwxOBvkGWGwbf9v0IJc5orE2xL0fS7z98VUOVWtqblRkFaLn2NNL2KKFTfW7uH6ZyJNKmH7OewB70f7f7Ziu/nYL54sEOjwZYxzT/+ez8AtnFIoyLj2bunn4Vges4WCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas7t1763360070t251t24988
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [125.120.152.51])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 4017320020957605270
To: "'Andrew Lunn'" <andrew@lunn.ch>
Cc: "'Vadim Fedorenko'" <vadim.fedorenko@linux.dev>,
	<netdev@vger.kernel.org>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Russell King'" <linux@armlinux.org.uk>,
	"'Simon Horman'" <horms@kernel.org>,
	"'Jacob Keller'" <jacob.e.keller@intel.com>,
	"'Mengyuan Lou'" <mengyuanlou@net-swift.com>,
	"'Vadim Fedorenko'" <vadim.fedorenko@linux.dev>,
	<netdev@vger.kernel.org>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Russell King'" <linux@armlinux.org.uk>,
	"'Simon Horman'" <horms@kernel.org>,
	"'Jacob Keller'" <jacob.e.keller@intel.com>,
	"'Mengyuan Lou'" <mengyuanlou@net-swift.com>
References: <20251112055841.22984-1-jiawenwu@trustnetic.com> <20251112055841.22984-6-jiawenwu@trustnetic.com> <b7702efc-9994-4656-9d4e-29c2c8145ab3@linux.dev> <001401dc5444$3e897f60$bb9c7e20$@trustnetic.com> <f7d7ed12-0c52-4b82-80eb-948b77b0ddaf@lunn.ch>
In-Reply-To: <f7d7ed12-0c52-4b82-80eb-948b77b0ddaf@lunn.ch>
Subject: RE: [PATCH net-next 5/5] net: txgbe: support getting module EEPROM by page
Date: Mon, 17 Nov 2025 14:14:29 +0800
Message-ID: <012801dc5789$6ea20440$4be60cc0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQIM7yZFIqUFPQBkfWoGGA7engjSjgHLnukhAszbvKkDQik1TwIdbyePtEVv84A=
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NQoDnqplJoTK3pCt+JsGvJQdf/XTpK0c6Gvz/tY+vtzrpHJwMf82tTAB
	DLo7FKnjRrpwVDtWd1o2erz0JtNCg4Gx8WYP0wuX7N7Qsch8plYcLX9DKxauusup1jcFJnH
	6AYRvDCTncD2Wcy5tsc8zjfCbR7aXg2JEEu/gMXnkfFvcEmVbe2tSAzsvVu1ocdDN32VhCq
	Y9GE3HU0xaQ7w0LMr3+jJVAEKy4ljLPFeC3rsmBKozZg9YZ5+UC90x6dvE/6cfa8viZPIFw
	K89dZAqHr76PgSvQ+3St145TGR57lhmrOtZrkBJHlXy0VUHX7BQi6ClcBlXS7FcRBHc2tel
	tjaxkRq/24/29nHP4EycUBQJEnA2AoqA/jYaWylyNWJFIHy97MLRIFv4mBUdI7aZMyLILjh
	jtwmksX1nZX0YiX1t0oYJMv0V0QsW6+r4E8UyCdx4LhH6+iN6zTLErZkeyaTm3pCFXICVOu
	HJNy7OVx/vuzSNii9E8XTaZPTeHnc/lmEzIN5AwkJiihCumwo3ut5NBQGnoQ5Gym4ef4pRL
	0Y104pnhfVhdk32GRiORCBpkCFJFHptQpOK+qH+is1Oid6r9LiSKe+M6XWklB4ToMcFYiVg
	JFvUzKIsHv82mbePxgcrkJka1XP7Xi2pxmE0lTBtmgQVhhGWVk2HY5jAfJhLQhF3M1Je0QJ
	OD4OLAmJ4vxC00TroCrAS3BTqLaAgYW1x7zCSt7bdS5iiTWHVv3Q6cYQUBfiNI+UGdA/Ov4
	jAdXzfW7W5u5bD1H3iOuLIEuHKdtBbyNXO4wUD3wcIjMH/400SYPtaxk+84eoz79/HHny6W
	wWhD7Q88SsqQzRWEZXodoi+Qv8jyIMMtv+1l+cYBaUltkiXEbgAR9gfYEnMKKQLnkaZxO6Y
	Nq7LBJYeLuPnncZKEhl9VF9p+KyJp1yhgEno8Qafy7Tfh5LgI5GvsaY7JeJj66tnXiPvL9L
	FtHPwJlfZS7UXfOyxxmMV//YmCHtPraSwR5tjYAX3BLiZ/QFsAa4XeF+n1hYJ1/uXukkOzV
	k5thT+MwbXvcX8khJrAd2/x6PAIbk=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

On Fri, Nov 14, 2025 6:19 AM, Andrew Lunn wrote:
> > For 1-byte data, wx_host_interface_command() can be used to set 'return_data'
> > to true, then page->data = buffer->data. For other cases, I think it would be more
> > convenient to read directly from the mailbox registers.
> 
> For 1-byte data, you need to careful where it is used. All the sensor
> values are u16 and you need to read a u16 otherwise you are not
> guaranteed to get consistent upper/lower bytes.
> 
> So i would not recommend 1 byte read, unless you have an SFP module
> which is known to be broken, and only supports 1 byte reads.

Thanks for the reminder.

But when I use 'ethtool -m', .get_module_eeprom_by_page() is always
invoked multiple times, with 'page->length = 1' in the first time.


