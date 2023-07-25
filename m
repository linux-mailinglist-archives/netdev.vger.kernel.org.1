Return-Path: <netdev+bounces-20946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA7C761FBE
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 19:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FFA51C20958
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 17:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53AC25176;
	Tue, 25 Jul 2023 17:03:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B763B3C23
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 17:03:08 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC16CFE
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 10:03:06 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fbc656873eso58167395e9.1
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 10:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690304585; x=1690909385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AaG67F5PV92jBTVwJ9fE09T/CxSxAbtkMLZu0XHwRSE=;
        b=j20Jca4+30PfyjlUeFlIdqXmUfj2deSxJMGqt+ezDJ0F5wKTMSLf6oZ/pN2Btf9eyj
         ECSmuDSF6GFuCXWjNIwVpEuiuOFd2CyEFVpw35aHj5M392PuuLaKyC1d3LcMx6q6ZcU2
         pA6Ryzis3F9oRT29J7/2rO1FFdeBFHCXBjHTAJBhOjco8+KOPKD3A7gAQpraQ+QMqABN
         WTYQvuxDd6bOnJwxXWVeREA7n2bM0hReU9kP9ftCcRrqfWcE/9gy25Fx+DjWm8bF7sdZ
         yGNlYFo3Ep3DUJOBZy4Nv6F/tmhJdN1ns5r1xCHv2NP5vgfrpPLxcJ+wwur16XuUTsvy
         u6Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690304585; x=1690909385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AaG67F5PV92jBTVwJ9fE09T/CxSxAbtkMLZu0XHwRSE=;
        b=RTwd+7r4JqqzmkPKf6wz7mIERy5kKj7XziqkGwaWO/AlAESYMYhKjvr/Xh3+uvpLHA
         JVwdstOv2AsKFEY1O7aECxWdwvSfyjXIQLB3GfB3N78obT95ybpF51RG6vUVFhsACHsS
         zuY5KLr7d9+QcJRCiL+161meYDQjJZPaFVk5bm7gopVdKCHbATlRbQyHyCcg62j57ZAZ
         /rJCZ3JP7UYP8cTGF0DdOreGHyH+qokaYZrR06+k/pri9I1zqSLU8SuL/82e6WtKsN6m
         /mCa1pubFNLX5m8ZYNoklI2NKuuZ1Yg4f7NzblxiXZehbVnAsBOQdsKUkBHGbF83w9Tv
         gPuw==
X-Gm-Message-State: ABy/qLbjld2SzTZciVuo6IoCTDknhKLh5+Rl53JYkE2t7QJVBaSk4KUr
	gNpMXVItje0ta08H+COqGiM=
X-Google-Smtp-Source: APBJJlE4BIQ40T4p8kltJFumDBMUuYFlKhRdQjBTKq3jOoSKLQZc9u2wCp2TFOmNs+ZEZlIF3NUCCg==
X-Received: by 2002:a05:600c:2205:b0:3fc:193:734e with SMTP id z5-20020a05600c220500b003fc0193734emr11609228wml.32.1690304584632;
        Tue, 25 Jul 2023 10:03:04 -0700 (PDT)
Received: from skbuf ([188.25.175.105])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c229a00b003fc3b03e41esm2041986wmf.1.2023.07.25.10.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 10:03:04 -0700 (PDT)
Date: Tue, 25 Jul 2023 20:03:02 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Mack <daniel.mack@holoplot.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, f.fainelli@gmail.com
Subject: Re: [PATCH] net: dsa: mv88e6xxx: use distinct FIDs for each bridge
Message-ID: <20230725170302.r3ajp2mbm6ntr4ej@skbuf>
References: <20230724101059.2228381-1-daniel.mack@holoplot.com>
 <20230724101059.2228381-1-daniel.mack@holoplot.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724101059.2228381-1-daniel.mack@holoplot.com>
 <20230724101059.2228381-1-daniel.mack@holoplot.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Daniel,

On Mon, Jul 24, 2023 at 12:10:59PM +0200, Daniel Mack wrote:
> Allow setups with overlapping VLAN IDs in different bridges by settting
> the FID of all bridge ports to the index of the bridge.
> 
> Read the FID back when detecting overlaps.
> 
> Signed-off-by: Daniel Mack <daniel.mack@holoplot.com>
> ---

You will have to give more details about what you're trying to do and
how, because my non-expert understanding of Marvell hardware is that
it's simply not possible to allow overlapping VLAN IDs in different
bridges without mapping them to the same FID, aka having them share the
same address database - which is not what we want.

In fact we should be going in the opposite direction, and eventually
convert mv88e6xxx to report ds->fdb_isolation = true - the fact that all
VLAN-unaware bridges share MV88E6XXX_VID_BRIDGED and MV88E6XXX_FID_BRIDGED
prevents us from doing that right now. Your patch is not exactly a correct
step in that direction.

My understanding is that there are some newer Marvell switches with an
8K entry VTU where VLANs might map to one FID or another depending on
port, but your patch does not handle that in the way that I would
expect.

Currently, if you want to use multiple bridges, you need to do one of
the following:
- create them with "vlan_default_pvid 0" and use them in "vlan_filtering 0"
  mode
- disable CONFIG_BRIDGE_VLAN_FILTERING (has the same effect as the above)
- if you want to use them in "vlan_filtering 1" mode, then each bridge
  needs to be created with a different vlan_default_pvid value (this value
  is irrelevant for the bridge operating in "vlan_filtering 0" mode).

>  drivers/net/dsa/mv88e6xxx/chip.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
> index c7d51a539451..dff271981c69 100644
> --- a/drivers/net/dsa/mv88e6xxx/chip.c
> +++ b/drivers/net/dsa/mv88e6xxx/chip.c
> @@ -2028,6 +2028,7 @@ static int mv88e6xxx_port_check_hw_vlan(struct dsa_switch *ds, int port,
>  	struct mv88e6xxx_chip *chip = ds->priv;
>  	struct mv88e6xxx_vtu_entry vlan;
>  	int err;
> +	u16 fid;
>  
>  	/* DSA and CPU ports have to be members of multiple vlans */
>  	if (dsa_port_is_dsa(dp) || dsa_port_is_cpu(dp))
> @@ -2037,11 +2038,16 @@ static int mv88e6xxx_port_check_hw_vlan(struct dsa_switch *ds, int port,
>  	if (err)
>  		return err;
>  
> +	err = mv88e6xxx_port_get_fid(chip, port, &fid);
> +	if (err)
> +		return err;
> +
>  	if (!vlan.valid)
>  		return 0;
>  
>  	dsa_switch_for_each_user_port(other_dp, ds) {
>  		struct net_device *other_br;
> +		u16 other_fid;
>  
>  		if (vlan.member[other_dp->index] ==
>  		    MV88E6XXX_G1_VTU_DATA_MEMBER_TAG_NON_MEMBER)
> @@ -2054,6 +2060,10 @@ static int mv88e6xxx_port_check_hw_vlan(struct dsa_switch *ds, int port,
>  		if (!other_br)
>  			continue;
>  
> +		err = mv88e6xxx_port_get_fid(chip, other_dp->index, &other_fid);
> +		if (err == 0 && fid != other_fid)
> +			continue;
> +
>  		dev_err(ds->dev, "p%d: hw VLAN %d already used by port %d in %s\n",
>  			port, vlan.vid, other_dp->index, netdev_name(other_br));
>  		return -EOPNOTSUPP;
> @@ -2948,6 +2958,11 @@ static int mv88e6xxx_port_bridge_join(struct dsa_switch *ds, int port,
>  		*tx_fwd_offload = true;
>  	}
>  
> +	/* Set the port's FID to the bridge index so bridges can have
> +	 * overlapping VLANs.
> +	 */
> +	err = mv88e6xxx_port_set_fid(chip, port, bridge.num);

To be clear, mv88e6xxx_port_set_fid() changes the port-default FID of
the packets, which is used to classify frames when the port 8021Q mode
is disabled and the port-default FID is not in the VTU. Currently, I
believe that is never the case in this driver, so the port-default FID
is never used, and the other call to mv88e6xxx_port_set_fid() could just
as well be removed.

IIRC, in standalone mode we install MV88E6XXX_VID_STANDALONE in the VTU
and set the port 8021Q mode to disabled, which means that all packets
will get classified to MV88E6XXX_FID_STANDALONE through the VTU mapping
and not through the port-default FID whose value you're changing now.

For VLAN-unaware bridge ports it's a similar story as for standalone
(802.1Q mode disabled), except that the port-default VID, as set up by
mv88e6xxx_port_commit_pvid(), is MV88E6XXX_VID_BRIDGED. This is also
present in the VTU, and is mapped to MV88E6XXX_FID_BRIDGED.

Each bridge VLAN (used only in VLAN-aware mode) has its own unique FID
as allocated by mv88e6xxx_atu_new(), which is always greater than 2
because of the first 2 FIDs being reserved by the driver. The VTU is not
namespaced per bridge. If br0 creates an ATU for VID 1 and gets a FID
for it, br1 either has to use the same FID for VID 1, or not use VID 1
at all. The driver writers decided that the 2nd option would be better.

I think you are trying to bypass that restriction in a way that doesn't
make much sense. Correct me if I'm wrong, but if I follow the intention
of your patch, I think that what you're thinking is that the port's
Default FID does something else (somehow namespaces all VLANs)?

To see where your proposal falls short, try to have communication
between 2 stations in different bridges br0 and br1, towards MAC address
00:01:02:03:04:05. There is a single ATU (single FID), and if you have
learning enabled, the ATU entry will bounce back and forth between a
port in br0, and a port in br1. Forwarding is still restricted, so when
another station tries to ping the 00:01:02:03:04:05 address and that
happens to be learned on a br1 port, you'll just see packet loss because
the switch won't permit communication between br0 and br1.

> + unlock: mv88e6xxx_reg_unlock(chip);
>  
> -- 2.41.0
> 
> 

Sorry, but:

pw-bot: cr

