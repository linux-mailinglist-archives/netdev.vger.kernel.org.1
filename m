Return-Path: <netdev+bounces-26054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D09B776AC3
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 23:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1BF51C20FD5
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 21:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E47F1D300;
	Wed,  9 Aug 2023 21:10:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E091C9E7
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 21:10:10 +0000 (UTC)
X-Greylist: delayed 600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Aug 2023 14:10:09 PDT
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BBD138
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 14:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=SuYKXbiQSoXZEz5mfCg5gD/UnTQOyRLetjmCNaPirb0=;
	t=1691615409; x=1692825009; b=ernC33V665vLmSfOlqamh7UgkMAhJyxXlbKVtr8SEO7VrB2
	gxby8KbEavmAYd+9iM6MQpfxvM87aOQEB33ynfUuVcK2Rr0OcDa63stt3fk5DwDLOdkkQR+7bE6Yw
	CGfaGUzPO4caGRwoTDTy7Lc56/kjNAESIeiighLOTvD5HbIYRISGKnL32O9ivZ6xFZBM0CJl5SRDT
	4ypMqkVDkdCYtq+ZnvsFNo5QGiGJQm3BtwkdRiSZumB87aOn9LC7CLi2hoPc14AOsmB82W5SXFyvR
	MAkBbITvvfHJxXaAcrF5sfkFKk0lrAN4zYFEpWhq4oxoP+yhjqniRbGEnSeMTs4Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qTqHU-00F7uX-2j;
	Wed, 09 Aug 2023 22:59:49 +0200
Message-ID: <6f4b7e118ac60394db7e5f8e062e8ddeb4370323.camel@sipsolutions.net>
Subject: Re: [PATCH net-next 03/10] genetlink: remove userhdr from struct
 genl_info
From: Johannes Berg <johannes@sipsolutions.net>
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com, 
 jiri@resnulli.us, philipp.reisner@linbit.com, lars.ellenberg@linbit.com, 
 christoph.boehmwalder@linbit.com, axboe@kernel.dk, pshelar@ovn.org, 
 jmaloy@redhat.com, ying.xue@windriver.com, jacob.e.keller@intel.com, 
 drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
 dev@openvswitch.org,  tipc-discussion@lists.sourceforge.net
Date: Wed, 09 Aug 2023 22:59:47 +0200
In-Reply-To: <20230809182648.1816537-4-kuba@kernel.org>
References: <20230809182648.1816537-1-kuba@kernel.org>
	 <20230809182648.1816537-4-kuba@kernel.org>
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
> Only three families use info->userhdr and fixed headers
> are discouraged for new families. So remove the pointer
> from struct genl_info to save some space. Compute
> the header pointer at runtime. Saved space will be used
> for a family pointer in later patches.

Seems fine to me, but I'm not sure I buy the rationale that it's for
saving space - it's a single pointer on the stack? I'd probably argue
the computation being pointless for basically everyone except for a
handful users?

Reviewed-by: Johannes Berg <johannes@sipsolutions.net>

johannes

