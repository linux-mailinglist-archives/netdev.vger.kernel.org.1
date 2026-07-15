Return-Path: <netdev+bounces-307635-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zL30G5/lVmpiCgEAu9opvQ
	(envelope-from <netdev+bounces-307635-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 03:42:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD824759EC6
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 03:42:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307635-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307635-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 902D9301C8B0
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 01:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A24C3368B1;
	Wed, 15 Jul 2026 01:42:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C6B327BEC
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 01:42:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784079771; cv=none; b=loEuDUbcfiUZbdxY3wpgQ29RPI5YGbjes5VJRTPxG+3EVcRsXZygyGoGtBc2PFxNsDr6Ujm2+d7omrm1MyWgAHVzEfdq32OX1NQV16/RvnUwmVDNVKBobEZTRNhRVTJQQ6ZjcptPfKRrtvnyKOJklI25qd9F7NPQLAvjY3H1Aa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784079771; c=relaxed/simple;
	bh=FkqbnLgfbX/PkNrWSqiWdIHM/TMGNDd1V2BQIr0wxNo=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=D5EzlI/WtaCCs+yjVZDu6aNwKSsPWfUeO9ZH7gyLOzEGWRsvWbERd1u47EfmKwGB3QnguYdgffCLVRks5M8YiogJdoywOZxBopAIb+meCG52w9CrBvW1xKj7Vp6riskSJBKnbYj7PTyOIGuRdb0Yi/rEnZtTN0BtI7B5kIxDmXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.194.254.142
X-QQ-mid:tivesync5t1784079697t7e947160
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [115.200.247.46])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 3329323566490880469
To: "'Jacob Keller'" <jacob.e.keller@intel.com>,
	<netdev@vger.kernel.org>
Cc: "'Duanqiang Wen'" <duanqiangwen@net-swift.com>,
	"'Mengyuan Lou'" <mengyuanlou@net-swift.com>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Simon Horman'" <horms@kernel.org>,
	"'Kees Cook'" <kees@kernel.org>,
	"'Przemek Kitszel'" <przemyslaw.kitszel@intel.com>
References: <069DF89AA8029189+20260713060441.276612-1-jiawenwu@trustnetic.com> <6ab773c8-6c43-4c53-86ed-46bbaecb8073@intel.com>
In-Reply-To: <6ab773c8-6c43-4c53-86ed-46bbaecb8073@intel.com>
Subject: RE: [PATCH net-next v2] net: libwx: disable TX VLAN offload for packets with >2 VLAN tags
Date: Wed, 15 Jul 2026 09:41:36 +0800
Message-ID: <0e3601dd13fb$12ea0ab0$38be2010$@trustnetic.com>
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
Thread-Index: AQLxvNkQjT+hsz/l7gMt8rrNSwW/qAI0s1o4tDLWIeA=
X-QQ-SENDSIZE: 520
Feedback-ID: tivesync:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: N4kMhpKju7/ptVRiazWLcHyGNMUxt7Oip50/PvN13Xpt/22VPXg9y/7Y
	M91OavF1DWEiJnCL+3nAIguTrMwEDHUyY7dofBhnRVK+gpHp0sVOD73voeA4IbEzKeEFiL+
	UWCN1GRqxma3LXmCbz6LWif397u+kvG7Lt+WN8MpZXQu+HSeCPeIIeUKyh2fQXnSYzbl5Sm
	QYCN7JkL3QVjVP7WVWfwHcgvNABL4kWuorhVsPGj34MOaYNLV2NHpS6A572iXQyNCUHl80X
	SYxyuKHIrLU9lgRpyjnOSxo4PoyJ6X3hWLdY/0s7m8b6Gm5Fqo8F7ZpLei989fqFljybPFl
	ez00h/ALfjjZUAU7glji+lEass5MjzjKCUh2mbZsi+8lW9gW4clBbcsUp0q4TS88OnK3dEN
	z21Z/qtXnzFM4vlNFk+jhOAQPsxAa2AHMZXMojljre34dOymV+4oDYQxYmBz0T/pDOaEFEr
	O2PLV5dM7rAl5a4/2zpAlOZE3WpXAoAkCY2soEmK6YoSVPsYbUpuhoTB36xCYCNYxaOu+Lc
	ylLH26Fq7+/qgRmVMpZwP9UR/xf/5T6jxwDrZ9v9/cHKH7opO+c7LMZvuhtC7npR43fMCk5
	04VmAbp0aSfrh2AOFkSLOXxyid7+m3I3IZFjFWkaCb0VmlfNZnZyu1ea4p+nAf4Fjc0atDV
	2kaPOuHBlDAhn7zR1jwvQ6Vs5xWMIBKdp8la+znXkn2plq8ortPd2d0VuyyZ9BJyb/b7Y6O
	0oRwxDpVytZygBC8zeshmIOGxYdghw3HaY8s36dSnhWjlWUUNIO4MBTgISGe31/pOj8aqJw
	XJIfV6s4G6y5c3enFN7pxpyGjngqVBuZLwKkaF3VBzF4z3SdwiI5xy18awLUqAAViXtJOYd
	Zih3XeKPI3Nlyr6P+n6+DlSjTBkX/ia1e5XxkNIyIZgMsh+JkKEyIz+FBAzGyASKX032m0i
	zS8qcqezFWyClwclO/6PFY31eNOaiPAsODOhShJtAKAJ/quGLYPpG4VDr0+O+NOhTm+rtCw
	P00QGmYbkX09LmiTIQnPE2hVl2jiWhtlNdzruc+VIGWGZ1TXyrxz6bzRUd8NJSLD3oy9vo2
	GSqWJsfJWuutsICCA+C7RvOJxXPhaqNWg==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	FROM_EXCESS_BASE64(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[trustnetic.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jacob.e.keller@intel.com,m:netdev@vger.kernel.org,m:duanqiangwen@net-swift.com,m:mengyuanlou@net-swift.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kees@kernel.org,m:przemyslaw.kitszel@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-307635-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CD824759EC6

On Wed, Jul 15, 2026 8:27 AM, Jacob Keller wrote:
> On 7/12/2026 11:04 PM, Jiawen Wu wrote:
> > The current hardware does not support TX VLAN offload for packets with
> > three or more VLAN tags. When such packets are transmitted with hardware
> > VLAN offload enabled, the hardware may malfunction or produce corrupted
> > frames.
> >
> > Add a check in wx_features_check() to parse the VLAN depth of the
> > skb. If more than two VLAN tags are detected (including both the
> > hardware tag and in-band tags), strip NETIF_F_HW_VLAN_CTAG_TX and
> > NETIF_F_HW_VLAN_STAG_TX from the feature set. This forces the
> > kernel networking stack to handle VLAN insertion in software for
> > these specific packets, ensuring correct transmission.
> >
> > Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> 
> 
> Is there a reason this was targeted at net-next instead of as a bug fix
> to net with a Fixes tag to the commit which first introduced VLAN tagging?
> 
> Thanks,
> Jake

Probably because I couldn't find a Fixes tag for it...

> 
> > ---
> > v2:
> > - Remove redundant 'parse_depth'.
> > - Optimize the loop.
> >
> > v1: https://lore.kernel.org/all/C1BF77C0E073A40C+20260710071831.210196-1-jiawenwu@trustnetic.com
> > ---
> >  drivers/net/ethernet/wangxun/libwx/wx_lib.c | 24 +++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> > index 814d88d2aee4..34542b3dc884 100644
> > --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> > +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> > @@ -3228,6 +3228,30 @@ netdev_features_t wx_features_check(struct sk_buff *skb,
> >  				    netdev_features_t features)
> >  {
> >  	struct wx *wx = netdev_priv(netdev);
> > +	__be16 type = skb->protocol;
> > +	u16 vlan_depth = ETH_HLEN;
> > +	u32 vlan_num = 0;
> > +
> > +	if (skb_vlan_tag_present(skb))
> > +		vlan_num++;
> > +
> > +	while (eth_type_vlan(type)) {
> > +		struct vlan_hdr vhdr, *vh;
> > +
> > +		vh = skb_header_pointer(skb, vlan_depth, sizeof(vhdr), &vhdr);
> > +		if (unlikely(!vh))
> > +			break;
> > +
> > +		type = vh->h_vlan_encapsulated_proto;
> > +		vlan_depth += VLAN_HLEN;
> > +		vlan_num++;
> > +
> > +		if (vlan_num > 2) {
> > +			features &= ~(NETIF_F_HW_VLAN_CTAG_TX |
> > +				      NETIF_F_HW_VLAN_STAG_TX);
> > +			break;
> > +		}
> > +	}
> >
> >  	if (!skb->encapsulation)
> >  		return features;
> 
> 


