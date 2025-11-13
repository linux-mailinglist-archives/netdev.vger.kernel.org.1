Return-Path: <netdev+bounces-238185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DBDC556D2
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 03:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5AB884E2B9D
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 02:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E8C28D8D9;
	Thu, 13 Nov 2025 02:24:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9BA2F7453
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 02:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763000646; cv=none; b=NUq07IoQ9bcocuQYwLrQnmH7+U1g2fjVvqkmK7v1s8FAm9fGGRDvt0FjidACbaxYpJDUvm60xk/bi7eLz/JttD9bAYa5SsrxLxq3Ev83sZmr6fx2c6yb/upR0c6R6YWdGnJWenJTQaoVeifeJOfeg81PUYXc3YrVsNXG4NglGFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763000646; c=relaxed/simple;
	bh=wiq5Dm6QIbc9Xwy0zA6I/kq6u7RqCrhyjcsmO0CW/mY=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ua8BBJJj63sFH+6cFZbp49MbAhYEWuRmoQMJRwlwD9Mq3wu/jDmXiHJBmyR0QSYChCHGqngp/Ob4kfx78tGnQY2N2N5aIO//wcfijmFn7gigSlEIw1KYuHn9JsvW3INYaDCemDOzgubGzlVn/gHNRcdrXhJKR1dqVJGFZW/WsgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas8t1763000500t737t06795
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [115.200.224.204])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 3438845263827835990
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
References: <20251112055841.22984-1-jiawenwu@trustnetic.com> <20251112055841.22984-6-jiawenwu@trustnetic.com> <b7702efc-9994-4656-9d4e-29c2c8145ab3@linux.dev>
In-Reply-To: <b7702efc-9994-4656-9d4e-29c2c8145ab3@linux.dev>
Subject: RE: [PATCH net-next 5/5] net: txgbe: support getting module EEPROM by page
Date: Thu, 13 Nov 2025 10:21:39 +0800
Message-ID: <001401dc5444$3e897f60$bb9c7e20$@trustnetic.com>
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
Thread-Index: AQIM7yZFIqUFPQBkfWoGGA7engjSjgHLnukhAszbvKm0ad2HoA==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OadMa6AQUq1e+PabBJkP0gNZjaf47lbJSHlA1j5XuYu6Qz+ek2ZKg5wl
	QG2J+gfU9jYTzGU5deViLUUNPmlvRbtBqpy4CmCjA5vOOGNZQWXCTOFf8MGVd9c2jsRRzTJ
	mFwyRuExdfSXpbdyJhJlpHDkF20BJ/L/aZfra7Qi5afBeRpdSJ0TT6Rx0mSCl7PTes6OEpa
	JsCZybpM22JJ0SaDuM/pxwUs++8TFuVXckDDlSrL46lEHAQ3yq3GFJHTUTXPLMAtvC8ExtV
	exl2n9ZvPulRkJp3NQIfxHT+EfjNrweRwEiohWmaP9UAYAK2xdetdBWcVy1l0bO7dIeoRZG
	YGyPccEGTK894RtXX7EXk39tpzMJApRwm19fUZOIoKG1gzf7r2iSm3ertCEuFb6UUcANcK0
	0yiUHd459S9F3O2dffBuds/xMyPXqRIUKG4sAP1T6yE2Rk8PlaB0wrAyC1eq2QPos6KoV+d
	EOFQxAvvQpdKXaP4VLa3ehmwVmlTrawCckADpvJo/wRnV5+DWFUODV+gTNUv128yHjihBTm
	gc8U5uVHa7NFSgDKfT7Vo4B15xRtTx4DCnt6TUemfdHNeaDKYVGoMAZNteJKb1FChSDkH/M
	B34s3HBUkYNzoIqVfunCnSPywWJIh3SPVftCr7IMAIrhtmehkqNjlW5M+WBmdAiqaDjB9uP
	WEhMzLBQszumv1LtRazcM4n44PgMRPtzLnQ3sbbFUXpHGSpWCoBrHv53VSpQp9iyBeCu+Tr
	kbYViIv/cjWX3XRoxFhS+yUVgsiYa8EqGccIdfLw3ueh3nRbHyjyE2d4IVk2TJcJHqTp3gz
	X+OcCmn3QpcKwaOd3+xNnNnFCbjd6OXfkwk0sBqgRWCEDMQYhanlpJsTvEri1adBJ7N0tME
	KJEMzn+NEKbenNMgu0Wb+C6Qu8q6VsYsOk9Un5zbwOp8qI5RzDfNY9X4P5He/EWYig89KDY
	CNokx+6UxJMS9marpaTyJ4dGm2vc5GIBrYGTW8R3EUOEWHOXWyC/mjbpT9ivkpYV6kGUoJZ
	H4aY3AQuxhx6ZcGaRPzyQmQD2OrfXz7BQXJi6IXmCPP5J0yQyEbOhMPHmkfSAzvY39vCZX1
	c5rCRzcD2Od
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

On Wed, Nov 12, 2025 8:49 PM, Vadim Fedorenko wrote:
> On 12/11/2025 05:58, Jiawen Wu wrote:
> > Getting module EEPROM has been supported in TXGBE SP devices, since SFP
> > driver has already implemented it.
> >
> > Now add support to read module EEPROM for AML devices. Towards this, add
> > a new firmware mailbox command to get the page data.
> >
> > Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> > ---
> >   .../net/ethernet/wangxun/txgbe/txgbe_aml.c    | 37 +++++++++++++++++++
> >   .../net/ethernet/wangxun/txgbe/txgbe_aml.h    |  3 ++
> >   .../ethernet/wangxun/txgbe/txgbe_ethtool.c    | 30 +++++++++++++++
> >   .../net/ethernet/wangxun/txgbe/txgbe_type.h   | 11 ++++++
> >   4 files changed, 81 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
> > index 3b6ea456fbf7..12900abfa91a 100644
> > --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
> > +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
> > @@ -73,6 +73,43 @@ int txgbe_test_hostif(struct wx *wx)
> >   					WX_HI_COMMAND_TIMEOUT, true);
> >   }
> >
> > +int txgbe_read_eeprom_hostif(struct wx *wx,
> > +			     struct txgbe_hic_i2c_read *buffer,
> > +			     u32 length, u8 *data)
> > +{
> > +	u32 buf_size = sizeof(struct txgbe_hic_i2c_read) - sizeof(u8);
> > +	u32 total_len = buf_size + length;
> > +	u32 dword_len, value, i;
> > +	u8 local_data[256];
> > +	int err;
> > +
> > +	if (total_len > sizeof(local_data))
> > +		return -EINVAL;
> 
> if it's really possible? SFF pages are 128 bytes, you reserve 256 bytes
> of local buffer. What are you protecting from?

It can be changed to 128 + sizeof(struct txgbe_hic_i2c_read).

> 
> > +
> > +	buffer->hdr.cmd = FW_READ_EEPROM_CMD;
> > +	buffer->hdr.buf_len = sizeof(struct txgbe_hic_i2c_read) -
> > +			      sizeof(struct wx_hic_hdr);
> > +	buffer->hdr.cmd_or_resp.cmd_resv = FW_CEM_CMD_RESERVED;
> > +
> > +	err = wx_host_interface_command(wx, (u32 *)buffer,
> > +					sizeof(struct txgbe_hic_i2c_read),
> > +					WX_HI_COMMAND_TIMEOUT, false);
> > +	if (err != 0)
> > +		return err;
> > +
> > +	dword_len = (total_len + 3) / 4;
> 
> round_up()?
> 
> > +
> > +	for (i = 0; i < dword_len; i++) {
> > +		value = rd32a(wx, WX_FW2SW_MBOX, i);
> > +		le32_to_cpus(&value);
> > +
> > +		memcpy(&local_data[i * 4], &value, 4);
> > +	}
> 
> the logic here is not clear from the first read of the code. effectively
> in the reply you have the same txgbe_hic_i2c_read struct but without
> data field, which is obviously VLA, but then you simply skip the result
> of read of txgbe_hic_i2c_read and only provide the real data back to the
> caller. Maybe you can organize the code the way it can avoid double copying?

Because the length of real data is variable, now it could be 1 or 128. But the total
length of the command buffer is DWORD aligned. So we designed only a 1-byte
data field in struct txgbe_hic_i2c_read, to avoid redundant reading and writing
during the SW-FW interaction.

For 1-byte data, wx_host_interface_command() can be used to set 'return_data'
to true, then page->data = buffer->data. For other cases, I think it would be more
convenient to read directly from the mailbox registers.

> 
> > +
> > +	memcpy(data, &local_data[buf_size], length);
> > +	return 0;
> > +}
> > +
> >   static int txgbe_identify_module_hostif(struct wx *wx,
> >   					struct txgbe_hic_get_module_info *buffer)
> >   {
> > diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.h
> > index 7c8fa48e68d3..4f6df0ee860b 100644
> > --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.h
> > +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.h
> > @@ -7,6 +7,9 @@
> >   void txgbe_gpio_init_aml(struct wx *wx);
> >   irqreturn_t txgbe_gpio_irq_handler_aml(int irq, void *data);
> >   int txgbe_test_hostif(struct wx *wx);
> > +int txgbe_read_eeprom_hostif(struct wx *wx,
> > +			     struct txgbe_hic_i2c_read *buffer,
> > +			     u32 length, u8 *data);
> >   int txgbe_set_phy_link(struct wx *wx);
> >   int txgbe_identify_module(struct wx *wx);
> >   void txgbe_setup_link(struct wx *wx);
> > diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
> > index f553ec5f8238..1f60121fe73c 100644
> > --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
> > +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
> > @@ -10,6 +10,7 @@
> >   #include "../libwx/wx_lib.h"
> >   #include "txgbe_type.h"
> >   #include "txgbe_fdir.h"
> > +#include "txgbe_aml.h"
> >   #include "txgbe_ethtool.h"
> >
> >   int txgbe_get_link_ksettings(struct net_device *netdev,
> > @@ -534,6 +535,34 @@ static int txgbe_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
> >   	return ret;
> >   }
> >
> > +static int
> > +txgbe_get_module_eeprom_by_page(struct net_device *netdev,
> > +				const struct ethtool_module_eeprom *page_data,
> > +				struct netlink_ext_ack *extack)
> > +{
> > +	struct wx *wx = netdev_priv(netdev);
> > +	struct txgbe_hic_i2c_read buffer;
> > +	int err;
> > +
> > +	if (!test_bit(WX_FLAG_SWFW_RING, wx->flags))
> > +		return -EOPNOTSUPP;
> > +
> > +	buffer.length = (__force u32)cpu_to_be32(page_data->length);
> > +	buffer.offset = (__force u32)cpu_to_be32(page_data->offset);
> 
> maybe txgbe_hic_i2c_read::length and txgbe_hic_i2c_read::offset should
> be __be32 ?

Sure.

> 
> > +	buffer.page = page_data->page;
> > +	buffer.bank = page_data->bank;
> > +	buffer.i2c_address = page_data->i2c_address;
> > +
> > +	err = txgbe_read_eeprom_hostif(wx, &buffer, page_data->length,
> > +				       page_data->data);
> > +	if (err) {
> > +		wx_err(wx, "Failed to read module EEPROM\n");
> > +		return err;
> > +	}
> > +
> > +	return page_data->length;
> > +}
> > +
> >   static const struct ethtool_ops txgbe_ethtool_ops = {
> >   	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
> >   				     ETHTOOL_COALESCE_TX_MAX_FRAMES_IRQ |
> > @@ -568,6 +597,7 @@ static const struct ethtool_ops txgbe_ethtool_ops = {
> >   	.set_msglevel		= wx_set_msglevel,
> >   	.get_ts_info		= wx_get_ts_info,
> >   	.get_ts_stats		= wx_get_ptp_stats,
> > +	.get_module_eeprom_by_page	= txgbe_get_module_eeprom_by_page,
> >   };
> >
> >   void txgbe_set_ethtool_ops(struct net_device *netdev)
> > diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
> > index e72edb9ef084..3d1bec39d74c 100644
> > --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
> > +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
> > @@ -353,6 +353,7 @@ void txgbe_do_reset(struct net_device *netdev);
> >   #define FW_PHY_GET_LINK_CMD             0xC0
> >   #define FW_PHY_SET_LINK_CMD             0xC1
> >   #define FW_GET_MODULE_INFO_CMD          0xC5
> > +#define FW_READ_EEPROM_CMD              0xC6
> >
> >   struct txgbe_sff_id {
> >   	u8 identifier;		/* A0H 0x00 */
> > @@ -394,6 +395,16 @@ struct txgbe_hic_ephy_getlink {
> >   	u8 resv[6];
> >   };
> >
> > +struct txgbe_hic_i2c_read {
> > +	struct wx_hic_hdr hdr;
> > +	u32 offset;
> > +	u32 length;
> > +	u8 page;
> > +	u8 bank;
> > +	u8 i2c_address;
> > +	u8 data;
> > +};
> you removed struct txgbe_hic_i2c_read in the patch 2 just to introduce
> it in this patch?

Yes, the name of these structure would be more appropriate.

> 
> > +
> >   #define NODE_PROP(_NAME, _PROP)			\
> >   	(const struct software_node) {		\
> >   		.name = _NAME,			\
> 
> 


