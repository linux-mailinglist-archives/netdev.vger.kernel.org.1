Return-Path: <netdev+bounces-41058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B698B7C9776
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 02:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 538E1B20BD3
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 00:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A355B10E7;
	Sun, 15 Oct 2023 00:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=infradead.org header.i=@infradead.org header.b="d0woM+J5"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98A77FA
	for <netdev@vger.kernel.org>; Sun, 15 Oct 2023 00:55:25 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE0CCC;
	Sat, 14 Oct 2023 17:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uAzEWPlAFbI+/fsmaBKX8Evs419Pr/qqscJnwH/iIs8=; b=d0woM+J55qDqjJ1yABgFrsVnsR
	1VtkjUnmUIsUx9gOna03H0aiRUVr237NSfBV+2FSvxgDmGVi4bCvdXZkqFXoQElWDHjovK73UlLYl
	ZPpcKXrpU34AKeoQ4yly9TtviEdwKiisWqHRmM+9CpgVU25jng3t2fdRcZAIhTRjSndtpSQ1yhwzu
	bTx9nNLURWqATdLs5rQvPBrC8mSggNsSJ3iYOT9VlIb9iCj3zRw+t9Jg2w1ifOOwkWndmY1gE1MwJ
	QgcoD/Lrs5T94mVhFHTWQ0lTBIcrwqOo5NCBEjCXa7YewUAEiMltcf0M0RjTcgtmJP4wFPz48wGqI
	rmH/ztaw==;
Received: from jlbec by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qrpPT-001Key-1W;
	Sun, 15 Oct 2023 00:55:11 +0000
Date: Sat, 14 Oct 2023 17:55:08 -0700
From: Joel Becker <jlbec@evilplan.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	Eric Dumazet <edumazet@google.com>, hch@lst.de,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	horms@kernel.org
Subject: Re: [PATCH net-next v4 3/4] netconsole: Attach cmdline target to
 dynamic target
Message-ID: <ZSs4bC+NST2hkT/E@google.com>
Mail-Followup-To: Breno Leitao <leitao@debian.org>, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com,
	Eric Dumazet <edumazet@google.com>, hch@lst.de,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	horms@kernel.org
References: <20231012111401.333798-1-leitao@debian.org>
 <20231012111401.333798-4-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012111401.333798-4-leitao@debian.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever
 come to perfection.
Sender: Joel Becker <jlbec@ftp.linux.org.uk>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 04:14:00AM -0700, Breno Leitao wrote:
> Enable the attachment of a dynamic target to the target created during
> boot time. The boot-time targets are named as "cmdline\d", where "\d" is
> a number starting at 0.
> 
> If the user creates a dynamic target named "cmdline0", it will attach to
> the first target created at boot time (as defined in the
> `netconsole=...` command line argument). `cmdline1` will attach to the
> second target and so forth.
> 
> If there is no netconsole target created at boot time, then, the target
> name could be reused.
> 
> Relevant design discussion:
> https://lore.kernel.org/all/ZRWRal5bW93px4km@gmail.com/
> 
> Suggested-by: Joel Becker <jlbec@evilplan.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Joel Becker <jlbec@evilplan.org>

> ---
>  drivers/net/netconsole.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index e153bce4dee4..6e14ba5e06c8 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -629,6 +629,23 @@ static const struct config_item_type netconsole_target_type = {
>  	.ct_owner		= THIS_MODULE,
>  };
>  
> +static struct netconsole_target *find_cmdline_target(const char *name)
> +{
> +	struct netconsole_target *nt, *ret = NULL;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&target_list_lock, flags);
> +	list_for_each_entry(nt, &target_list, list) {
> +		if (!strcmp(nt->item.ci_name, name)) {
> +			ret = nt;
> +			break;
> +		}
> +	}
> +	spin_unlock_irqrestore(&target_list_lock, flags);
> +
> +	return ret;
> +}
> +
>  /*
>   * Group operations and type for netconsole_subsys.
>   */
> @@ -639,6 +656,17 @@ static struct config_item *make_netconsole_target(struct config_group *group,
>  	struct netconsole_target *nt;
>  	unsigned long flags;
>  
> +	/* Checking if a target by this name was created at boot time.  If so,
> +	 * attach a configfs entry to that target.  This enables dynamic
> +	 * control.
> +	 */
> +	if (!strncmp(name, NETCONSOLE_PARAM_TARGET_PREFIX,
> +		     strlen(NETCONSOLE_PARAM_TARGET_PREFIX))) {
> +		nt = find_cmdline_target(name);
> +		if (nt)
> +			return &nt->item;
> +	}
> +
>  	nt = alloc_and_init();
>  	if (!nt)
>  		return ERR_PTR(-ENOMEM);
> -- 
> 2.34.1
> 

-- 

"Nobody loves me,
 Nobody seems to care.
 Troubles and worries, people,
 You know I've had my share."

			http://www.jlbec.org/
			jlbec@evilplan.org

