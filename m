Return-Path: <netdev+bounces-14569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E7C7426FB
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 15:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82217280D20
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 13:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8AB2584;
	Thu, 29 Jun 2023 13:09:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705862565
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 13:09:57 +0000 (UTC)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050:0:465::102])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69073E5B
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 06:09:55 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4QsJhG5CwHz9skl;
	Thu, 29 Jun 2023 15:09:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pmachata.org;
	s=MBO0001; t=1688044190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j3odc1c63zxkiU6kzNfKVT3jatm1e85dNq/XPH7zY+I=;
	b=J6qk37509qJi+wEL2MWzIY59au1yFBLaoy0lmXy/AYgyqZosEEQ5VMptMGEOf2R6cPsGDQ
	NYBenqubFxbxA/ekLu8sshzt1lHDbWeCF3KdZf0+DtgpYbTIRlqMEMP5njT691gAhRRnx8
	FH0EbNrf6nwkOUx0sv/0+Wto1PpU760frLTvysurrR/dXLNiGaAdwwjLioJ9R1rpzNXs7S
	1oWHAqa3Gdy4BWbbLfCoEh7dI6fRNngLh8B16itEzyeBo2DTf9Uclmn3ArR9fQ2vEljUL2
	SH7AX3dehoQnn39BRArQZLkc/MDAMqs1Sli+gdG5BE04LhdudqtadpFZP3SOyw==
References: <20230628233813.6564-1-stephen@networkplumber.org>
 <20230628233813.6564-2-stephen@networkplumber.org>
From: Petr Machata <me@pmachata.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2 1/5] dcb: fully initialize flag table
Date: Thu, 29 Jun 2023 15:08:48 +0200
In-reply-to: <20230628233813.6564-2-stephen@networkplumber.org>
Message-ID: <87ttuqe7oj.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 4QsJhG5CwHz9skl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


Stephen Hemminger <stephen@networkplumber.org> writes:

> And make the flag table const since only used for lookup.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Reviewed-by: Petr Machata <me@pmachata.org>

