Return-Path: <netdev+bounces-36526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E37F77B0445
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 14:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 1DFF81C20432
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 12:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CECC923750;
	Wed, 27 Sep 2023 12:34:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605161846
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 12:34:31 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBEC139
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 05:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=z+9T6Q8VB19drZtQ5we5k57Xme4D+WIa9xUSY1DWfnA=; b=RxwxA20cDMGiGwS8eX1ned51Ly
	+oW+JGhX4/4SJDqMXcz97s7Uq31r1e9nE1DDiWu3ToRs9h4bY9x+UEVd+3skc13tTNnHhal4ocoGE
	nlKW0B0sDwCF7W/DI9uFcLqE8rjzL4MbzSSNbiTkG0AaqSMdZG6pxPNELY6A/UtAaUFE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qlTkJ-007dso-9F; Wed, 27 Sep 2023 14:34:27 +0200
Date: Wed, 27 Sep 2023 14:34:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, gospo@broadcom.com
Subject: Re: [PATCH net-next v2 1/9] bnxt_en: Update firmware interface to
 1.10.2.171
Message-ID: <3ff0cdd5-0b4d-4868-8b0b-21e08416561e@lunn.ch>
References: <20230927035734.42816-1-michael.chan@broadcom.com>
 <20230927035734.42816-2-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927035734.42816-2-michael.chan@broadcom.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 26, 2023 at 08:57:26PM -0700, Michael Chan wrote:
> The main changes are the additional thermal thresholds in
> hwrm_temp_monitor_query_output and the new async event to
> report thermal errors.

A quick question. Is this backwards compatible with older firmware?

> -#define HWRM_VERSION_RSVD 118
> -#define HWRM_VERSION_STR "1.10.2.118"
> +#define HWRM_VERSION_RSVD 171
> +#define HWRM_VERSION_STR "1.10.2.171"

These don't appear to be used anywhere?

      Andrew

