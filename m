Return-Path: <netdev+bounces-302123-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id T++iKes6PmpjBwkAu9opvQ
	(envelope-from <netdev+bounces-302123-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 10:40:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 022016CB6EC
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 10:40:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=XQ4iLO3X;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302123-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302123-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4C7E30841DD
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 08:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807882E6116;
	Fri, 26 Jun 2026 08:34:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544063E5A11;
	Fri, 26 Jun 2026 08:34:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782462847; cv=none; b=myD80hPXJmiOsCg1pI0WqNNwvr6Jp250+fUkPjQUxriUADSJKLFUgkzeh6IDOo8VHbZhliMAqmciR13KKyDS1Rv8s724iU1UKPW8F2cmDDWx3a8JsMwNM5CBJzHkMNZbeBjnMHG7Pl7Uov1REZfCoqR9TACNP17ZcBeCStPGbcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782462847; c=relaxed/simple;
	bh=xdzlg1QpaIDIrRyGpdS3xwLhozduuRF0hDOjQLQNG5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SvIqidewIj39JoLLEhxLsp1EA0zdS7o6dPrOZbv6G3jyKbrX+ohGyZpHs/zckFn+hOY/Xw+nihzd+3kWd9nTfkR6m/R0T4ne7SaIx/whdb1bl8sPlhQrmIVrx4MhRGa+q549Is4n2RrVsz9eBsnlR5i5Q9bdTK8HLvAAoJMiPKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XQ4iLO3X; arc=none smtp.client-ip=185.246.85.4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 852794E40940;
	Fri, 26 Jun 2026 08:33:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5795760232;
	Fri, 26 Jun 2026 08:33:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0723C104C839C;
	Fri, 26 Jun 2026 10:33:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782462837; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=Fl/6D2iiLAuBnGZZ9BAjfhN71sA1OHwcFqVLpgKZ0yQ=;
	b=XQ4iLO3XnqhVIw2WQ96ldk8M4w0P8kAZe9BnJPaRFrcTTGuNDXwLkUS3lXGYp+sAjjRTM0
	2ZWFym89G7dcjmavh1HF7Gh+DcC6JN3L/LbRJm2Z55xLk2btObpDlNXOi7d9ITpHHKrCuj
	qdFWC6cRlLO0njOO1FQTqQ1Kfj1ozejbvFJtxdORedYEl3POYJlbFd+WXK3Y/qjEwHp9MI
	XGuC45BhyahjzDBLwrMQDiQE2LfdBSYxZPOSR4dniQINIJG3ArJgt7D6f7s+6iDas8gmQ0
	NWvfC40naxwycdUdIsvILCqeZspbgZ7FI9N7DP6soSqAkVqbl9cB4zOTzIZQUg==
Message-ID: <65d26fd2-fbb3-49cd-a9ac-07863d9a8909@bootlin.com>
Date: Fri, 26 Jun 2026 10:33:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] Documentation: networking: Add a test plan for
 ethtool pause validation
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Florian Fainelli <f.fainelli@gmail.com>, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20260522175109.198059-1-maxime.chevallier@bootlin.com>
 <20260526172447.10ca4b9e@kernel.org>
 <5cb8e2b4-8eb6-4446-9b90-1cd4c7964cd9@lunn.ch>
 <38bafe7e-d419-46f7-8fa7-87e9183e578c@bootlin.com>
 <58f37d6e-973b-4242-be82-0561ccdb1a6f@lunn.ch>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <58f37d6e-973b-4242-be82-0561ccdb1a6f@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302123-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:linux@armlinux.org.uk,m:hkallweit1@gmail.com,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:o.rempel@pengutronix.de,m:vladimir.oltean@nxp.com,m:f.fainelli@gmail.com,m:thomas.petazzoni@bootlin.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:ffainelli@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,armlinux.org.uk,gmail.com,lwn.net,linuxfoundation.org,pengutronix.de,nxp.com,bootlin.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,bootlin.com:dkim,bootlin.com:mid,bootlin.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 022016CB6EC


> Sphinx follows pythons object orientate structure. So you could have a
> class test_ethtool_pause_advertising, with class documentation. And
> then methods within the class which are individual tests.  The
> commented out section would then be method documentation.

Good point, so maybe something along these lines :

 - A class for the test
 - methods for indivitual tests
 - For readability, I've written what the internal test helper would look
   like (_adv_test), and how a test would look like without the helper in
   adv_rx_on_tx_on().

I'm already diving into coding, but it helps me a bit in the definition of the
"description" format :)

this is what the class would look like :


class test_ethtool_pause_advertising:
    """Pause advertisement

    Validate that changing pause params through the ETHTOOL_MSG_PAUSE command
    translates to a change in the advertised pause params, and that these
    parameters are correct w.r.t the supported pause params and requested pause
    params.
    
    This exercises the .set_pauseparams() ethtool ops for MAC configuration,
    as well as the reconfiguration of the PHY's advertising and negociation.
    
    On non-phylink MACs, the MAC should call phy_set_sym_pause() to update the
    PHY's advertising, and restart a negotiation with phy_start_aneg() if
    need be. Failure to do so will result on the wrong advertising parameters.
    
    Pn phylink-enabled MACs, phylink deals with the PHY reconfiguration provided
    the MAC driver calls phylink_ethtool_set_pauseparam().
    
    Failing this test likely means that the PHY driver is not correctly advertising
    pause settings, either due to the MAC triggering a PHY reconfiguration,
    a misconficonfiguration of the advertising registers by the PHY, or by
    mis-handling the phydev->advertising bitfield in the PHY driver directly.
    
    The validation is made by looking at the advertised modes locally, as well as
    what the peer's 'lp_advertising' values report.

    cfg -- local device's interface configuration
    peer -- peer device handle
    """

    def _adv_test(cfg, peer, rx, tx, adv, not_adv):
        ret = cfg.run(f"ethtool -A ethX rx {rx} tx {tx} autoneg on")
        ksft_eq(ret, 0)

        linkmodes = cfg.get_advertising()
        if adv:
            ksft_in(adv, linkmodes, f"rx {rx} tx {tx} must advertise {adv}")

        if not_adv:
            ksft_not_in(not_adv, linkmodes, f"rx {rx} tx {tx} must not advertise {not_adv}")

        remote_linkmodes = peer.get_lp_advertising()

        if adv:
            ksft_in(adv, linkmodes, f"PHY does not advertise {adv}")

        if not_adv:
            ksft_not_in(not_adv, linkmodes, f"PHY incorrectly advertises {not_adv}")


    @ksft_ethtool_needs_supported_allof([Pause])
    def adv_rx_on_tx_on(cfg, peer) -> None:
        """Advertising test with rx on tx on

        - run 'ethtool -A ethX rx on tx on autoneg on'
        - FAIL if the return isn't 0
        - FAIL if ETHTOOL_A_LINKMODES_OURS's advertised values does not contain
          "Pause" or contains "Asym_Pause"
        - FAIL if peer's lp_advertising doesn't contain "Pause" or contains
          "Asym_Pause"
        - Succeed otherwise
        """
        ret = cfg.run('ethtool -A ethX rx on tx on autoneg on')
        ksft_eq(ret, 0)

        linkmodes = cfg.get_advertising()
        ksft_in('Pause', linkmodes, "rx on tx on must advertise Pause")
        ksft_not_in('Asym_Pause', linkmodes, "rx on tx on must not advertise Asym_Pause")

        remote_linkmodes = peer.get_lp_advertising()
        ksft_in('Pause', linkmodes, "PHY does not advertise Pause")
        ksft_not_in('Asym_Pause', linkmodes, "PHY incorrectly advertises Asym_Pause")


    @ksft_ethtool_needs_supported_allof([Pause, Asym_Pause])
    def adv_rx_on_tx_off(cfg, peer) -> None:
        """Advertising test with rx on tx off

        - run 'ethtool -A ethX rx on tx off autoneg on'
        - FAIL if the return isn't 0
        - FAIL if ETHTOOL_A_LINKMODES_OURS's advertised values does not contain
          "Pause" and "Asym_Pause"
        - FAIL if peer's lp_advertising doesn't contain "Pause" and "Asym_Pause"
        - Succeed otherwise
        """

        _adv_test(cfg, peer, 'on', 'off', ["Pause", "Asym_Pause"], [])

    @ksft_ethtool_needs_supported_allof([Asym_Pause])
    def adv_rx_off_tx_on(cfg, peer) -> None:
        """Advertising test with rx off tx on

        - run 'ethtool -A ethX rx off tx on autoneg on'
        - FAIL if the return isn't 0
        - FAIL if ETHTOOL_A_LINKMODES_OURS's advertised values does not contain
          "Asym_Pause" or contains "Pause"
        - FAIL if peer's lp_advertising doesn't contain "Pause" and "Asym_Pause"
        - Succeed otherwise
        """

        _adv_test(cfg, peer, 'off', 'on', ["Asym_Pause"], ["Pause"])


Maxime

