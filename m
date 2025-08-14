Return-Path: <netdev+bounces-213552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C99B2594A
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 03:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5633D189B1D2
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 01:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86462226861;
	Thu, 14 Aug 2025 01:53:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F1C14A4F0
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 01:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755136392; cv=none; b=LJIDWdJRber7Ap4/HpRXdStSA3HDClCMrLRwh6PqNTqFCYoYegW3zX8ZCElQeZRWfghkphfxwxqUFUW0PNa/nt5Fpu5jT6ecxCnc5KKcXRWWBdGFFmjDcwrdzZVmqQ2ZGJzzV3OIGwd3qqtkMPn7u1Psmtf2MGEzs4PZcyuHoqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755136392; c=relaxed/simple;
	bh=XSvxllJ+lsccOnQGUAPGojsawqgYcBwz9/3gzuvQHUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eN+SRkGv+cuVptkSuzVxLwT87lV/cEbyBzLJjViKlnVWHYq7bV4xt2F5eUXrNKUowYkgYOzeIl3VBlg1c3D83YRFHRYxF/2rp9IFCG+I+5DvU8lxp8diRME7wW73qUzYvCzWmUE63iis0Mwn3F2meL5Hnh5xj7SXf8alfdGn27o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz19t1755136366t8d6f46ef
X-QQ-Originating-IP: eiGpyvKsWFLtyjrJNqrg67GlKWrqZZMWVLv9hkrZXpY=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 14 Aug 2025 09:52:44 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10519244942744142129
Date: Thu, 14 Aug 2025 09:52:44 +0800
From: Yibo Dong <dong100@mucse.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] net: rnpgbe: Add register_netdev
Message-ID: <463679C4547B6274+20250814015244.GA1031326@nic-Precision-5820-Tower>
References: <20250812093937.882045-1-dong100@mucse.com>
 <20250812093937.882045-6-dong100@mucse.com>
 <e410918e-98aa-4a14-8fb4-5d9e73f7375e@linux.dev>
 <B41E833713021188+20250813090405.GC965498@nic-Precision-5820-Tower>
 <354593d1-2504-407e-98fb-235fcaf61d87@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <354593d1-2504-407e-98fb-235fcaf61d87@linux.dev>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: N4WhQbLQyIqSRgQSGyqv18fL3ytm4ztJLUjepinSB3xnhwg+cOGhz/Bb
	tz9MzzKT5BpPUaL01bCy3HCSWYHnZdpTEYFYpnXRis3uz6XH+/Mc12IyVVYJZPFt1et/FUu
	9ZZIRME3IXvwIpmj+zsywidkPZ5gFh5JhjgGcn64AprbNmyKE+vAI0Dq5wpvNfMYCSMf3pa
	0ju6VUknBi8zw4R4DVQJ78BKui9noUxoNoIFVAtLKQJ2VdzWhv2ZDxzfmb+glcrz9v390ia
	9dQK89wre7q9DqyCGLTTpZghwnrNKbu+id3Wy30caTjgF2yvxARqfJe0Lq9ik4HBHKa40wv
	BgodxOWBVewKj40HyUeh82ra2+nt8V/B2nKkpvNOf6/9rAkmAOGOeVFcGdaTlkTsbx94LOU
	2CDuoAKC63Dv647ekmuoNXBRXvu8nwdG8EVD4qtMNXXLqNMAByfw21vv7oSzdGmgF4cVfFr
	Otd6mWePidwQFi7SdwfPEabjngGoLUtvP+rUco65FfKCfKagREZUJ92PRiBNGU6FUFkcFRv
	kkY/OiszHgQHBBkVPu9x4xjsZAkdLM99kWm7ypO/2AJazRryZTA/0nn7aSwB2dEAtYI0QXu
	gQyTiIT9HsiIaVuoW09thqSBBfatGs7LfnBDkNjBn0Ind0UeEyesw9Xgm+2+2QKqgKctrWw
	ECdEGJcXd7rtEy4NBFGymBWo103eVHcA7pM393jdW/eDq4WsLnAzl/GbAzVfwjWvegcIUQu
	OEyA5bugrdO7T6sOdFINchcWsS+NMP2cLC/Z+794rBwg94vEu/6bXrhidbmYU0KJwYEjRAu
	ZhKgjWXg8JGRRdu3t1HDZQoYswY1lALr+0C49Iuet4eVrrFE6Uv3fbIqokJPuOUclEtmiSv
	RfSyilXvv/1Fjw8hSCe3loBEj8MBff4/B0jBuTfBXEx1OyOCAnGYGAnE2ijRyFTv6VN4eSl
	PIar/9WvsWq7FXz+8stApqqwPouJOm2PTgqkQadXoNgL7fc5R4rOykqyv
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

On Wed, Aug 13, 2025 at 01:50:34PM +0100, Vadim Fedorenko wrote:
> On 13/08/2025 10:04, Yibo Dong wrote:
> > On Tue, Aug 12, 2025 at 04:32:00PM +0100, Vadim Fedorenko wrote:
> > > On 12/08/2025 10:39, Dong Yibo wrote:
> > > > Initialize get mac from hw, register the netdev.
> > > > 
> > > > Signed-off-by: Dong Yibo <dong100@mucse.com>
> > > > ---
> > > >    drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    | 22 ++++++
> > > >    .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   | 73 ++++++++++++++++++
> > > >    drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |  1 +
> > > >    .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 76 +++++++++++++++++++
> > > >    4 files changed, 172 insertions(+)
> > > > 
> > > > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> > > > index 6cb14b79cbfe..644b8c85c29d 100644
> > > > --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> > > > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> > > > @@ -6,6 +6,7 @@
> > > >    #include <linux/types.h>
> > > >    #include <linux/mutex.h>
> > > > +#include <linux/netdevice.h>
> > > >    extern const struct rnpgbe_info rnpgbe_n500_info;
> > > >    extern const struct rnpgbe_info rnpgbe_n210_info;
> > > > @@ -86,6 +87,18 @@ struct mucse_mbx_info {
> > > >    	u32 fw2pf_mbox_vec;
> > > >    };
> > > > +struct mucse_hw_operations {
> > > > +	int (*init_hw)(struct mucse_hw *hw);
> > > > +	int (*reset_hw)(struct mucse_hw *hw);
> > > > +	void (*start_hw)(struct mucse_hw *hw);
> > > > +	void (*init_rx_addrs)(struct mucse_hw *hw);
> > > > +	void (*driver_status)(struct mucse_hw *hw, bool enable, int mode);
> > > > +};
> > > > +
> > > > +enum {
> > > > +	mucse_driver_insmod,
> > > > +};
> > > > +
> > > >    struct mucse_hw {
> > > >    	void *back;
> > > >    	u8 pfvfnum;
> > > > @@ -96,12 +109,18 @@ struct mucse_hw {
> > > >    	u32 axi_mhz;
> > > >    	u32 bd_uid;
> > > >    	enum rnpgbe_hw_type hw_type;
> > > > +	const struct mucse_hw_operations *ops;
> > > >    	struct mucse_dma_info dma;
> > > >    	struct mucse_eth_info eth;
> > > >    	struct mucse_mac_info mac;
> > > >    	struct mucse_mbx_info mbx;
> > > > +	u32 flags;
> > > > +#define M_FLAGS_INIT_MAC_ADDRESS BIT(0)
> > > >    	u32 driver_version;
> > > >    	u16 usecstocount;
> > > > +	int lane;
> > > > +	u8 addr[ETH_ALEN];
> > > > +	u8 perm_addr[ETH_ALEN];
> > > 
> > > why do you need both addresses if you have this info already in netdev?
> > > 
> > 
> > 'perm_addr' is address from firmware (fixed, can't be changed by user).
> > 'addr' is the current netdev address (It is Initialized the same with
> > 'perm_addr', but can be changed by user)
> > Maybe I should add 'addr' in the patch which support ndo_set_mac_address?
> 
> But why do you need 'addr' at all? Current netdev address can be
> retrieved from netdev, why do you need to store it within driver's
> structure?
> 
> 

Ok, I will remove addr and use netdev->dev_addr if driver use it.


