Return-Path: <netdev+bounces-26048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF716776A91
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 22:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEC731C212BB
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 20:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC011D2E5;
	Wed,  9 Aug 2023 20:56:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F25024512
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 20:56:58 +0000 (UTC)
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DC7115
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 13:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=sobAV9CBC1Hr0XKHSgS6gn0ryTi4gFGqZji6pGBciZA=;
	t=1691614616; x=1692824216; b=hhPhAb1mrtIsfw5cCQFtyR/4JZq7CNVlTnAI+n9RzBik8kr
	eOmDEF4nVppHjJfWLKW/Bh1d3s22G2hlPxkxDTu4hEBl03Z5VOkQHg3uzGoUO0/lN3oOzaw4ZF+14
	3BQ8hGJ/e1a1I5E4OT3xe3ECxz5eQEq3pPEU6O3y2DLGfW9cvAcGBBNJEtn9uw1UMXV38JitODOX5
	KztCK3UBYp4qV4MH6RLRN9vfsX/8ZtkkuHEJmysLBEdeAFQpDVrtAbEU85EyxH7syRPCmfNd8eYDL
	Cc4VMRflFXKdRC75YcHCeqHwlTeKCwqPP08r8sxWfttvJAdn0D6tA/RDWJ+GRnaQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qTqEW-00F7j6-0X;
	Wed, 09 Aug 2023 22:56:44 +0200
Message-ID: <f5e671d0cb0e6084fe498f971117df44e95b3fbc.camel@sipsolutions.net>
Subject: Re: [PATCH net-next 01/10] genetlink: use push conditional locking
 info dumpit/done
From: Johannes Berg <johannes@sipsolutions.net>
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com, 
	jiri@resnulli.us, jacob.e.keller@intel.com
Date: Wed, 09 Aug 2023 22:56:43 +0200
In-Reply-To: <20230809182648.1816537-2-kuba@kernel.org>
References: <20230809182648.1816537-1-kuba@kernel.org>
	 <20230809182648.1816537-2-kuba@kernel.org>
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
> Add helpers which take/release the genl mutex based
> on family->parallel_ops. Remove the separation between
> handling of ops in locked and parallel families.

Looks nice to me, but the subject seems to have gotten mangled in
rephrasing? Feels like that to me, anyway.

Other than that,
Reviewed-by: Johannes Berg <johannes@sipsolutions.net>

johannes

