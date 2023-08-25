Return-Path: <netdev+bounces-30677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CB078882F
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 15:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B068A1C20F3D
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 13:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C06D523;
	Fri, 25 Aug 2023 13:14:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2797DCA79
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 13:14:28 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683AD1FD3;
	Fri, 25 Aug 2023 06:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=WcztSKj5cpoHARaecgwtq07bIuRdK/t/+wgohiVvEWU=; b=Aw
	6BcijSAGACN5JRCAIn4fHKk7BGfUG1q8Fnh6pgmgpQEhmOoEhI6lmHbsuJ6mniOKKWwhfpJhHG/vE
	8Zv3o7RvhrvaJnVdmPaRRgf0qBi7Vcwp3RnfuiUg8Xbl1wuqt0dLkE67TfGMMdS+Tpdg+1KlB9BzN
	aBuZtFplTKNbSuw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qZWdg-0055lW-Rs; Fri, 25 Aug 2023 15:14:12 +0200
Date: Fri, 25 Aug 2023 15:14:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, airat.gl@gmail.com
Subject: Re: [PATCH net] dt-bindings: net: dsa: marvell: fix wrong model in
 compatibility list
Message-ID: <f9889926-a20a-4002-9e8b-2735a24f9c51@lunn.ch>
References: <20230825082027.18773-1-alexis.lothore@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230825082027.18773-1-alexis.lothore@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 25, 2023 at 10:20:27AM +0200, Alexis Lothoré wrote:
> From: Alexis Lothoré <alexis.lothore@bootlin.com>
> 
> Fix wrong switch name in compatibility list. 88E6163 switch does not exist
> and is in fact 88E6361
> 
> Fixes: 9229a9483d80 ("dt-bindings: net: dsa: marvell: add MV88E6361 switch to compatibility list")
> Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

