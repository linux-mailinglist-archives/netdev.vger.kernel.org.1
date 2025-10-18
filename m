Return-Path: <netdev+bounces-230674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1F6BED1A0
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 16:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A85A65834B2
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 14:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538B527E05A;
	Sat, 18 Oct 2025 14:42:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738E91C28E;
	Sat, 18 Oct 2025 14:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760798570; cv=none; b=DWFLgLSTPMnnCVQDejABNj2DZ/0I37Sx4s5HHJxpq7T+c5/i9KFGeJ58EcJ2ojhZ3nXrwXcgDTC4t1hqoDbV96nS2m8RMgru0z3avBxIRpxEXCr5g2ZvQY9wceWW/GoDvtRX7it3izlKS/li2mruJoae/ZF4fMr5XMNfj0mBpRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760798570; c=relaxed/simple;
	bh=Yiokp8AOA5MBIRRXxZYT3h+Zvsu/4zjHnYtyy0zJE7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/UDq4gk9/kVO1jTJ4FjNUp6aymyA4AFAB8WIq9iK75ZKY5Mrq05D0jfVsD/QYyBVskyER+SMF0xPOuVjyjAmTYChwe99R0NkwgWMYlQH8PY1WCkgbTcyfcbSPByO2zR8+YcNtYFw5vjcW5LuyRoecWQukVpbki2D3Oej33a20w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz19t1760798552t654e3757
X-QQ-Originating-IP: hsCyHceUJdBsC2HmerHfDa/gauk7WW3wy8RM1wqSyZI=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 18 Oct 2025 22:42:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16127192191837545862
Date: Sat, 18 Oct 2025 22:42:30 +0800
From: Yibo Dong <dong100@mucse.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, corbet@lwn.net, andrew+netdev@lunn.ch,
	danishanwar@ti.com, vadim.fedorenko@linux.dev,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v14 3/5] net: rnpgbe: Add basic mbx ops support
Message-ID: <F5F360A04D1E1CAA+20251018144230.GA4362@nic-Precision-5820-Tower>
References: <20251014072711.13448-1-dong100@mucse.com>
 <20251014072711.13448-4-dong100@mucse.com>
 <20251017170703.3c2dba37@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017170703.3c2dba37@kernel.org>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: Ob047hH1itO57d3RtzjpdoVn7PaYRVnU9L3cRxvoQtYJhUC5rlAPJ8xH
	xyJIP1/dZsahx5E3zgFoV54KT/gp9UE8FfnfhDB0F3OYgGQh++nPgC3KwQOUJx8YSZk53EQ
	l4j7xcUXj6jbcwpw5x6x07HW6cLbj/YqvxvPoEzxKtWzszUyHtCGfoFgTn/WPt6SIEqUpAF
	saAjUrAA9tf3aMnPqxACKTLm6ZFVBCkXSZJz7EbYa46D6aKf+NF/RNGZkhSgnGBM0T9ybsv
	h31ck7GXkFHCuk9RhtIvePNXLJnkskMWu7huUsCLEiinozLj1ja6SWiRaOZhjbBSXERTxym
	jhGmYdMQZ2gNSUwM5o3x45ByU5p/W/STzk2yEPGGhUAm2hUFan8wQ+GqAUHnn/DeALyrYxS
	hRM3QLavRofzmN0EJ+Iptuaa3C6yiCXg2FJJZ8/KYgwim1Q7dkc2bhMB33olmvNKlQBou2H
	h2FZ1smWqft1BOFFSTt9LaS8R+nZpSeUPNz/C9wPSTsZUmWWozQzLs/n+48t+tFGD66CJj/
	jpjyd9SJFA5BbnRKmzRY2MebPlSgktod38qqS08cXFgixDxskdMAqIF0/hMTmyv8pu6pnei
	xpoiWeo5fjplC+Ql6oVZxPgV1IDe5hXlMhDnLVTpg3ZRPwxGRku9J5FR3Vsk/aTItsTE8X8
	U/tgU1bJW8K+mQ9brO0eyfEm7sa2jYIIcWXvlTp/C8zA8UYxvbSrk27V+lhtu4+KxEyuYNe
	O8M1c65yYtsOY1Q/XZNF6bN6+xsznYNRdJOLKybLzqqgTcnzFGElCAPdT8rgm2ZhwI5Y/Um
	mDxsLm6bTBwTQF7yMf+Tt6Ka57d3Z+Sw65KZ/eoNMynJQjTtNmZcmTsOQjaiq4LMiGEs6N6
	Pp9CjhUPEq4tOSTb1vbPcmfpE5ifwGQMX9Jcj0wb5T7fagjwW4zCZOmGG9c2LOkeQG5UZ/C
	ywcxLOXk9Z0NTgJjbRc8FcVnnky57M6PcJoXChF5TfXLBrd8qVAp47at4tQga4fmBypD742
	9f94Ki19OYiYtXWuMc
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

Hi, Jakub:

On Fri, Oct 17, 2025 at 05:07:03PM -0700, Jakub Kicinski wrote:
> On Tue, 14 Oct 2025 15:27:09 +0800 Dong Yibo wrote:
> > +struct mucse_mbx_stats {
> > +	u32 msgs_tx; /* Number of messages sent from PF to fw */
> > +	u32 msgs_rx; /* Number of messages received from fw to PF */
> > +	u32 acks; /* Number of ACKs received from firmware */
> > +	u32 reqs; /* Number of requests sent to firmware */
> > +};
> 
> Probably no point adding these stats until you can expose them to the
> user..
> 

Ok, I will remove this for this patch.

By the way, I think there is a similar situation in patch5 (about
tx_dropped), just bellow:

+ * rnpgbe_xmit_frame - Send a skb to driver
+ * @skb: skb structure to be sent
+ * @netdev: network interface device structure
+ *
+ * Return: NETDEV_TX_OK
+ **/
+static netdev_tx_t rnpgbe_xmit_frame(struct sk_buff *skb,
+				     struct net_device *netdev)
+{
+	struct mucse *mucse = netdev_priv(netdev);
+
+	dev_kfree_skb_any(skb);
+	mucse->stats.tx_dropped++;
+
+	return NETDEV_TX_OK;
+}

tx_dropped stats is sugguested by MD Danish Anwar <danishanwar@ti.com> here:
https://lore.kernel.org/netdev/94eeae65-0e4b-45ef-a9c0-6bc8d37ae789@ti.com/
----
> +static netdev_tx_t rnpgbe_xmit_frame(struct sk_buff *skb,
> +				     struct net_device *netdev)
> +{
> +		dev_kfree_skb_any(skb);
> +		return NETDEV_TX_OK;
> +}

Extra indentation on these two lines. Also, the function just drops all
packets without any actual transmission. This should at least increment
the drop counter statistics.
----

And update to my own stats here:
https://lore.kernel.org/netdev/20250923181639.6755cca4@kernel.org/

And I am not sure how to deal with it since 'mucse->stats.tx_dropped' is
not exposed to the user just like mbx_stats.
Please give me some sugguestion, thanks.



