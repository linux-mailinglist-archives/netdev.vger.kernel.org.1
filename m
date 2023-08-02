Return-Path: <netdev+bounces-23597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A59D76CA72
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 12:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CDAD1C20EDF
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 10:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F7C63C6;
	Wed,  2 Aug 2023 10:06:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF0C6AA1
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 10:06:10 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BE610D2
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 03:06:09 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fe12820bffso41850525e9.3
        for <netdev@vger.kernel.org>; Wed, 02 Aug 2023 03:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690970768; x=1691575568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eBDOVrUpzIFbZzQrcbiGwS/yYS5ar/ORWcEmd0pJOmk=;
        b=smT/kOMy8tlW27XeLcZIAZ50TQbt497n55jkvfKH6Q3m9L11aDOL+Hcq8wzbA7IulO
         9k+rIINVvVJUVplwyiFWvHgXFPfrbTNUbrZ8yy9CuafWGfOdWVqYqfvkw1/NYy9zefrX
         A+O7PR3ahqgezrd9qIGQgnRNunJNRvUMR6G44I1Nd/h7FVQCcpAgLU5yOxrbpBNEY/V7
         ak6di7bc9vN60xGPHHcoi5bDgJTBvUfhY6VD+pKupjPbKkReSte6ZAoQCjiMlxqJG8/b
         dOQp4337z7YNsmavZGgRcynAqQlMtg8QfsBAtK+EnGValWZH4Z5dbJToGgsmhqP/FlhF
         +eoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690970768; x=1691575568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eBDOVrUpzIFbZzQrcbiGwS/yYS5ar/ORWcEmd0pJOmk=;
        b=TSrHZ38fTfhqmgHJjPawuHlBERBM5PcER0zEQXrvwIpWDDPq/gs33vg4zmJ3iC8iYC
         ETGuwHFDPqVvMuStgpYQYEkiHcqHV31Iwcw8AoKoNKIenl9Vs6za0moI9GRPKo49GY5t
         JtFqbE/CP504Z6HM9c5d2gQptSV+V1R+qXQhZ9DhXoF01omfGgMikX6qQA47ZdtksVHm
         jxqaSyApwtbqlyaS6/OI6c5YszAewy/Pa+lup6KGNjKMMeQVEp16jJGLkP+k+Pqp66rK
         /qHgKfLDl8T6niktC3k77Qk3uFDMHcObncJD3eJj0wMoI31YjhupA5XDTYj/Z6tmEiM6
         gcQQ==
X-Gm-Message-State: ABy/qLb4kXEDJE0copvYHtUDzGM4ixPfan/QBvYCjf+gune/3TsCo3p3
	+CoSdx98SNIZ8PlKF4aC4NU=
X-Google-Smtp-Source: APBJJlF832W4ok/m5MgqUiMdfVV/fCQPKueuatB5TE9uw2KIm9ZcVOnvnWCAwbUmf9KvED1kui63fQ==
X-Received: by 2002:a5d:464c:0:b0:317:7330:bd82 with SMTP id j12-20020a5d464c000000b003177330bd82mr4360383wrs.8.1690970767686;
        Wed, 02 Aug 2023 03:06:07 -0700 (PDT)
Received: from skbuf ([188.27.185.41])
        by smtp.gmail.com with ESMTPSA id z1-20020adfd0c1000000b0031424f4ef1dsm18715961wrh.19.2023.08.02.03.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 03:06:07 -0700 (PDT)
Date: Wed, 2 Aug 2023 13:06:05 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: hellcreek: Replace bogus comment
Message-ID: <20230802100605.b2o2yafjsdflndpi@skbuf>
References: <20230801131647.84697-1-kurt@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801131647.84697-1-kurt@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 01, 2023 at 03:16:47PM +0200, Kurt Kanzenbach wrote:
> Replace bogus comment about matching the latched timestamp to one of the
> received frames. That comment is probably copied from mv88e6xxx and true for
> these switches. However, the hellcreek switch is configured to insert the
> timestamp directly into the PTP packets.
> 
> While here, remove the other comments regarding the list splicing and locking as
> well, because it doesn't add any value.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

