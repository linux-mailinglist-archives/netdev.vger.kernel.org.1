Return-Path: <netdev+bounces-15129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91302745C93
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 14:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1BD01C209B4
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 12:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EA8EAF1;
	Mon,  3 Jul 2023 12:52:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB406DDBE
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 12:52:04 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6004DCA
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 05:52:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 882CB21983;
	Mon,  3 Jul 2023 12:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1688388721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MZZ+ry/lR32sPR78S7GH0jL+iH6wzqmrbRIRiIsA218=;
	b=m+n2RgnCq+uAC/ESbwp9Rb+s7lJbZYlNTh7Byc7E0ykGnwSgMCRNbqaHZSFAyyAKWzXNl7
	XKIu9C6D0KiZebubXl2LJduTJUv9QACSll7SsFvcH1c5be/d0v4Zkq3M2t8uQ99odC9PLL
	TsvF7RT/a0pnlShiILS+xRgWANIjsv4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1688388721;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MZZ+ry/lR32sPR78S7GH0jL+iH6wzqmrbRIRiIsA218=;
	b=QAG9tdzZR4TUrmNoEamL13qjMj7i+M5K5jnaH46byynECU0V3yZD1PHknjfSdo9vjQ0/lq
	CUT7Fgou3rThbVAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 71761138FC;
	Mon,  3 Jul 2023 12:52:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 0jedGnHEomToBQAAMHmgww
	(envelope-from <chrubis@suse.cz>); Mon, 03 Jul 2023 12:52:01 +0000
Date: Mon, 3 Jul 2023 14:53:05 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Cc: Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	Richard Cochran <richardcochran@gmail.com>,
	lkft-triage@lists.linaro.org,
	"David S. Miller" <davem@davemloft.net>,
	Nathan Chancellor <nathan@kernel.org>,
	Saeed Mahameed <saeed@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	Gal Pressman <gal@nvidia.com>, LTP List <ltp@lists.linux.it>
Subject: Re: [LTP] [PATCH net v1] ptp: Make max_phase_adjustment sysfs device
 attribute invisible when not supported
Message-ID: <ZKLEsTL8WC5Rc6nQ@yuki>
References: <20230627232139.213130-1-rrameshbabu@nvidia.com>
 <20230703051053.GC363557@pevik>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703051053.GC363557@pevik>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi!
> I wonder why LTP was Cc'ed.

Since the NULL dereference was found by the read_all LTP test.

-- 
Cyril Hrubis
chrubis@suse.cz

