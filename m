Return-Path: <netdev+bounces-26053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFA1776AB0
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 23:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0898C1C2133B
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 21:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9255C1D2E6;
	Wed,  9 Aug 2023 21:05:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887A324512
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 21:05:16 +0000 (UTC)
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56580210D
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 14:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=DxxrfxJdW+x6vHwwv13H/HcSziuw1ToHD20ksvqM8rE=;
	t=1691615113; x=1692824713; b=b7WJdTfRra1HvLw7tI7k/fu3deZvMPVxpFdM8LRaU8lkxxr
	+AgKV076mwyfM9QPwkot0QZDdb+RAS3+SGlDawVsZvj885jFox8v/uTQ/peweezb+0qVkHhfoc26P
	e7srthYZQeSO8EPuJ28mk5qvH9VajLhEoWT1SKifC6akhrzgtBcBACodstPlFg17bX7OqO/mmlWYQ
	URGg2+/6Cj23FaHHeGEv6cyguFN8Zeqj+7TuqjrR+i9jUhlTnuT7Iooa8glL0YefHErgYAOhuYILM
	3dJ5eR/YEvmv9FBR0r1Hn2j8AKza3Rvc6WDiqqUsPd+V2KDnEW7jgRVcp70g+oNw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qTqMM-00F8EE-2i;
	Wed, 09 Aug 2023 23:04:51 +0200
Message-ID: <4e0b764736eafde134e52e7609c6ad351a5282ad.camel@sipsolutions.net>
Subject: Re: [PATCH net-next 05/10] genetlink: use attrs from struct
 genl_info
From: Johannes Berg <johannes@sipsolutions.net>
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com, 
 jiri@resnulli.us, Jason@zx2c4.com, alex.aring@gmail.com,
 stefan@datenfreihafen.org,  miquel.raynal@bootlin.com,
 krzysztof.kozlowski@linaro.org, jmaloy@redhat.com,  ying.xue@windriver.com,
 floridsleeves@gmail.com, leon@kernel.org,  jacob.e.keller@intel.com,
 wireguard@lists.zx2c4.com, linux-wpan@vger.kernel.org, 
 tipc-discussion@lists.sourceforge.net
Date: Wed, 09 Aug 2023 23:04:47 +0200
In-Reply-To: <20230809182648.1816537-6-kuba@kernel.org>
References: <20230809182648.1816537-1-kuba@kernel.org>
	 <20230809182648.1816537-6-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 2023-08-09 at 11:26 -0700, Jakub Kicinski wrote:
> Since dumps carry struct genl_info now, use the attrs pointer
> use the attr pointer from genl_info and remove the one in
> struct genl_dumpit_info.

Some parts of that commit message got duplicated.

Otherwise looks fine,
Reviewed-by: Johannes Berg <johannes@sipsolutions.net>

johannes

