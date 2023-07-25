Return-Path: <netdev+bounces-20969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82102762053
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 19:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84AEC1C20F70
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 17:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4AB25922;
	Tue, 25 Jul 2023 17:37:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B2C25140
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 17:37:39 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2731F1FCF
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 10:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=j3fBU19mCK7dYAthE18CMNSSgh/eoxwK1STMXFgPZyM=; b=U7wdiHiYleWLlNda58fjGeiA7h
	C4OIzJgKEo+P3KF2id9KZZE3k+l11p8OEcqKv5OPDO8mD+2OJGsanutlWDSxiK5IhhcnfU8/mKOCp
	WQGSQSnz/SSBbt/+Xoh5qp+3mmbcH2pZz3S227dJfeZU/croppvzQsK8eOlANJpNBbHY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qOLyZ-002IEU-H0; Tue, 25 Jul 2023 19:37:35 +0200
Date: Tue, 25 Jul 2023 19:37:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	Jose.Abreu@synopsys.com, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next 4/7] net: pcs: xpcs: adapt Wangxun NICs for
 SGMII mode
Message-ID: <e8042272-72f1-4fba-bb42-cc4a3a1ca737@lunn.ch>
References: <20230724102341.10401-1-jiawenwu@trustnetic.com>
 <20230724102341.10401-5-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724102341.10401-5-jiawenwu@trustnetic.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> +	if (xpcs_dev_is_txgbe(xpcs))
> +		xpcs_write_vpcs(xpcs, DW_VR_XS_PCS_DIG_CTRL1, DW_CL37_BP);

xpcs_dev_is_txgbe(xpcs) is being used quite a bit, and its not cheep
since it is a memcmp(). So suggest you do it once and add a quirk flag
to the xpcs structure.

	Andrew

