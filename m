Return-Path: <netdev+bounces-29027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D497816CC
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 04:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5376A1C20CAA
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 02:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B729A28;
	Sat, 19 Aug 2023 02:47:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4946643
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 02:47:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE3ADC433C7;
	Sat, 19 Aug 2023 02:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692413221;
	bh=oU+6WMg6c2UrnTMLgklxjc7ykpSmhNqopEee8qwkVPk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UA/UNvXwmLrhSEAhg7lPYmOjNAVVkUkN9pybSImmVxT+0lHuWrCcaZDmCSoYrvjyf
	 YhhI8bWGwgB+/99XZjtcruhpCWdBrpxn6MzuLWby7GqJRFG8rl8Cp+0RQ1VUqQk3jF
	 mEoMvMZpzs2YDyofEWA2JeQE+79wztJn67eSs7aVEPegNN3LeoWHQEXUhIZblTGeku
	 CuQQZAb6wJZuVe6I1lmEZcIgOQSfklhXfzmvPyJ2w9ky5Jtg3bfDWdjkqgDwrb5fbq
	 HkwvaKBtm+RCRcUr1M0AFhFV57+Nb9oY7HsEgtMxvTIkF/G+3ZTn+MWUggMWo2BOeq
	 9NRqhAAGGxXfw==
Date: Fri, 18 Aug 2023 19:46:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Herve Codina <herve.codina@bootlin.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Lee Jones <lee@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Qiang
 Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Shengjiu Wang
 <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam
 <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Randy Dunlap
 <rdunlap@infradead.org>, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 21/28] net: wan: Add framer framework support
Message-ID: <20230818194658.369da77a@kernel.org>
In-Reply-To: <5f671caf19be0a9bb7ea7b96a6c86381e243ca4c.1692376361.git.christophe.leroy@csgroup.eu>
References: <cover.1692376360.git.christophe.leroy@csgroup.eu>
	<5f671caf19be0a9bb7ea7b96a6c86381e243ca4c.1692376361.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Aug 2023 18:39:15 +0200 Christophe Leroy wrote:
> From: Herve Codina <herve.codina@bootlin.com>
> 
> A framer is a component in charge of an E1/T1 line interface.
> Connected usually to a TDM bus, it converts TDM frames to/from E1/T1
> frames. It also provides information related to the E1/T1 line.

Okay, progress is being made, now it builds patch by patch.
Still some kdoc warnings remain (W=1 build only catches
kdoc warnings in sources, you gotta run ./scripts/kernel-doc -none
explicitly on the headers):

include/linux/framer/framer.h:27: warning: Enum value 'FRAMER_IFACE_E1' not described in enum 'framer_iface'
include/linux/framer/framer.h:27: warning: Enum value 'FRAMER_IFACE_T1' not described in enum 'framer_iface'
include/linux/framer/framer.h:35: warning: expecting prototype for enum framer_clock_mode. Prototype was for enum framer_clock_type instead
include/linux/framer/framer.h:47: warning: expecting prototype for struct framer_configuration. Prototype was for struct framer_config instead
include/linux/framer/framer.h:60: warning: cannot understand function prototype: 'enum framer_event '
include/linux/framer/framer.h:89: warning: Function parameter or member 'notify_status_work' not described in 'framer'
include/linux/framer/framer.h:89: warning: Function parameter or member 'notifier_list' not described in 'framer'
include/linux/framer/framer.h:89: warning: Function parameter or member 'polling_work' not described in 'framer'
-- 
pw-bot: cr

