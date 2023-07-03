Return-Path: <netdev+bounces-15020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 682CA7454B2
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 07:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B44EB280C79
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 05:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48A1659;
	Mon,  3 Jul 2023 05:10:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4284374
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 05:10:58 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF0B1B0
	for <netdev@vger.kernel.org>; Sun,  2 Jul 2023 22:10:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A3CD51FD6D;
	Mon,  3 Jul 2023 05:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1688361054;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+TUCxsfveH45IDKaeRKB7kWChuuAhgP3mEW0ncDgrpo=;
	b=S55YraYRK9PK7dDb/k9ZCs1bXob+VA3CCymWWLOqhcDKU6oaiJOYXqI3g6Y0HJguXlB9rR
	0SgulphT+UPpdkx5cuXqjeprYg0/V0wN/2ubh+59WPCyNscKuEVax1mFl75nIvqamgPdU+
	5Rnpjmmljt0T3DbI99TFW8LHJP6bdMk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1688361054;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+TUCxsfveH45IDKaeRKB7kWChuuAhgP3mEW0ncDgrpo=;
	b=zv6FQJA9i6auyrR5kR9M0wBrUXsbtE2fnAPNpD+NH6h3znzQnAap0ef9B1FuEU//LHP5CK
	A0vyRe612lo8geCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5F84613276;
	Mon,  3 Jul 2023 05:10:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id ygkXFl5YomRbGAAAMHmgww
	(envelope-from <pvorel@suse.cz>); Mon, 03 Jul 2023 05:10:54 +0000
Date: Mon, 3 Jul 2023 07:10:53 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: netdev@vger.kernel.org,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	Richard Cochran <richardcochran@gmail.com>,
	lkft-triage@lists.linaro.org, Nathan Chancellor <nathan@kernel.org>,
	Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	LTP List <ltp@lists.linux.it>
Subject: Re: [LTP] [PATCH net v1] ptp: Make max_phase_adjustment sysfs device
 attribute invisible when not supported
Message-ID: <20230703051053.GC363557@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20230627232139.213130-1-rrameshbabu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627232139.213130-1-rrameshbabu@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi all,

> The .adjphase operation is an operation that is implemented only by certain
> PHCs. The sysfs device attribute node for querying the maximum phase
> adjustment supported should not be exposed on devices that do not support
> .adjphase.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

I wonder why LTP was Cc'ed.

Kind regards,
Petr

