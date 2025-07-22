Return-Path: <netdev+bounces-208762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DA0B0CFD2
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 04:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A90E1AA7906
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 02:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34F01DED5D;
	Tue, 22 Jul 2025 02:41:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913B01E47CC
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 02:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753152109; cv=none; b=re/5HbqgDMEzrIg7uGa4jRb5BxhroH8ILUZo1+h04jfnry6VNYAq9fXFGV5/cnOcL4PTRzC2uSeW9CqBexQkEomxxsdTSte7g7dt5x5Oia9dqbipKcBl8AjMCh3bVVE2WNN774dwniZxHo1GXUBCp4nisrI7FsOLtivGTZum4A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753152109; c=relaxed/simple;
	bh=HlEovfXzbWSxYse9fwuVAeaZsMcFOemBV6rK34fNQYM=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=EAE0ryZnXbFHoEu2069Fap8m7+oDNSmDDjO29FQvZ5FGR0ddZMmxiob1rbeQVdNqgmMyREp6gzFHjRXClqo6KgYKzuTttbsknF2AH0mS9F9V6gnFQrTPbbiuDub8n0XgTvGEt25VxX7yLO4nZnpjhN1dISaG68sHVoBVXkVZFmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas9t1753152024t192t01187
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [36.24.205.22])
X-QQ-SSF:0001000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 4788300256366270627
To: "'Jacob Keller'" <jacob.e.keller@intel.com>,
	<netdev@vger.kernel.org>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Simon Horman'" <horms@kernel.org>
Cc: "'Mengyuan Lou'" <mengyuanlou@net-swift.com>
References: <20250721080103.30964-1-jiawenwu@trustnetic.com> <20250721080103.30964-2-jiawenwu@trustnetic.com> <d45910fb-f479-4991-85c8-7dd5e2642ff0@intel.com>
In-Reply-To: <d45910fb-f479-4991-85c8-7dd5e2642ff0@intel.com>
Subject: RE: [PATCH net-next v2 1/3] net: wangxun: change the default ITR setting
Date: Tue, 22 Jul 2025 10:40:12 +0800
Message-ID: <02ae01dbfab1$f30618a0$d91249e0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQMOVi+96r7/jeT4bPen62fEkV838gHXXZjLAcRge02xu9KmYA==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: M83iEva+1QDBL3edCA7iDIj509KOQzzUcbo+182Nr1M2zeEZoHcAWVJ2
	N8/ffM7tcpbTvK4erXSFyNRd2JQJST8qtO7TtTy7g3aQPiovRZD7aBB7hdlqBN/2sbXtXT/
	UiW4p7OFFRTSaM83B5Vo8RL2UNfXKi6fz5altn5z4voXMqT9JSHG+WzYrTv246vKpSKrv+k
	lKWDK68W1AnrYMw+3DL8oZfLxUOVCfJOBqkxItm0lGexrE6ToS31tVmZEw0D/nJYphOgcw8
	bL48zBxlofj1OjMOmIMxGAuyqtg3n34bEIgVkN/S7gAZUztYHOi3MGULKSb0oQRPoihyqML
	++kDF3Jq905BJj0aHUcox+UABkOUaJ1eN8s8Orai0Mb+F6sq5crv4UacDpuInjyvGEYcEnr
	uOuleYdRkwTZSYOqgI3fUglCKEtQRNAAUIz8/L7OCcQBpevEZc0iN1MCojFupxiSsBxUGer
	5QvwsVEPz3IUezuopMn1FS6P4bHE7EzqZh0d6SOYjiX+cSaER78SmtQr+eti0LkO/XsG9pv
	/qxP3+B4+baDLFAte+exRU8pMoHBtVOEDz/a1WSCgEoLuIazigjUm8+2Qh1dmW9dDcWFHU1
	GCNj66Pu/lV4UI/ayvppDm049fieZLtDyvaO3Pm6FMwp3HEO5EtY7CyRRUxQUAB3oo5KcAr
	gYGgfq2T62CSm4GtB/aqloNCw1W+2VM6D8SgeV1lwlnfEvz+qu26SOP2QAu553RFJqpSBys
	I2su131uNZRHGFVC8idcnOjf0Orhl/HUqyZYl0sX0ktDnvnBO8Qdds/6P9lVIdZbbTNuoOi
	sZ2h2RzLApKdi3HyMLcj605ppk53kRAEnuFqP6pMQmYLHAEcp+oovmIYwJvM76MEdkztLNe
	IN5QmTjfmKR59UssOwG9oPvCnqYdzWIgyUEqQlgG1jSXauRzWGdndxP9ajBObIs30wAFVZK
	iQFsU9pPI7cy+2klFM2b4xbecjsNF7xNGTSn4Td4ZgA9cC3jhgk6GoQ1UekbUEgDNG83Crn
	jKJJEDzpul+vRMxlmODZGL72S9MGDIjR6pv5khWg==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

On Tue, Jul 22, 2025 7:56 AM, Jacob Keller wrote:
> On 7/21/2025 1:01 AM, Jiawen Wu wrote:
> > For various types of devices, change their default ITR settings
> > according to their hardware design.
> >
> 
> I would generally expect a change like this to have a commit message
> explaining the logic or reasoning behind the change from the old values
> to the new values. Do you see benefit? Is this cleanup for the other 2
> patches in the series to make more sense? Is there a good reason the new
> values make sense?
> 
> > Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> > ---
> >  .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 24 +++++++------------
> >  drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  5 ++--
> >  2 files changed, 10 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> > index c12a4cb951f6..85fb23b238d1 100644
> > --- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> > +++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> > @@ -340,13 +340,19 @@ int wx_set_coalesce(struct net_device *netdev,
> >  	switch (wx->mac.type) {
> >  	case wx_mac_sp:
> >  		max_eitr = WX_SP_MAX_EITR;
> > +		rx_itr_param = WX_20K_ITR;
> > +		tx_itr_param = WX_12K_ITR;
> >  		break;
> >  	case wx_mac_aml:
> >  	case wx_mac_aml40:
> >  		max_eitr = WX_AML_MAX_EITR;
> > +		rx_itr_param = WX_20K_ITR;
> > +		tx_itr_param = WX_12K_ITR;
> >  		break;
> >  	default:
> >  		max_eitr = WX_EM_MAX_EITR;
> > +		rx_itr_param = WX_7K_ITR;
> > +		tx_itr_param = WX_7K_ITR;
> >  		break;
> >  	}
> >
> > @@ -359,9 +365,7 @@ int wx_set_coalesce(struct net_device *netdev,
> >  	else
> >  		wx->rx_itr_setting = ec->rx_coalesce_usecs;
> >
> > -	if (wx->rx_itr_setting == 1)
> > -		rx_itr_param = WX_20K_ITR;
> > -	else

default rx_itr_param here

> > +	if (wx->rx_itr_setting != 1)
> >  		rx_itr_param = wx->rx_itr_setting;
> >
> >  	if (ec->tx_coalesce_usecs > 1)
> > @@ -369,20 +373,8 @@ int wx_set_coalesce(struct net_device *netdev,
> >  	else
> >  		wx->tx_itr_setting = ec->tx_coalesce_usecs;
> >
> > -	if (wx->tx_itr_setting == 1) {
> > -		switch (wx->mac.type) {
> > -		case wx_mac_sp:
> > -		case wx_mac_aml:
> > -		case wx_mac_aml40:
> > -			tx_itr_param = WX_12K_ITR;
> > -			break;
> > -		default:
> > -			tx_itr_param = WX_20K_ITR;
> > -			break;
> 
> It looks like you previously set some of these values here, but now you
> set them higher up in the function.
> 
> Its a bit hard to tell whats actually being changed here because of that.

In fact, here it's just a change of default rx/tx itr for wx_mac_em from
20k to 7k. It's an experience value from out-of-tree ngbe driver, to get
higher performance on various platforms.

As for the other changes, just cleanup the code for the next patches.



