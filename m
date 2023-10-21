Return-Path: <netdev+bounces-43182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B80B37D1AAD
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 05:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98FD51C20756
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 03:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4FBA59;
	Sat, 21 Oct 2023 03:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y25EEV2L"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73679A4C;
	Sat, 21 Oct 2023 03:49:10 +0000 (UTC)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBDE99;
	Fri, 20 Oct 2023 20:49:08 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6bbfb8f7ac4so291346b3a.0;
        Fri, 20 Oct 2023 20:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697860148; x=1698464948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K3HOC/wXeks16fUtvvw3sAzv6UwudNS5m0LmKpkToQg=;
        b=Y25EEV2LM0BYqg/hkcPsoJEaalrJwdxn7Lhl1IukkBD+Wtzy3QsjhibX/kmT/jBqGm
         OiTvEUwNC7/qgiPb1bXle1JuWmlS4OAZEE70//C2Pp+Cn9zdpOQSVXUoke7YuUv/h2/f
         adRHesEvk/mqBkgYr1neAXnI+o46J8SGOcwjg/YMu6cHYHD0OwVcLXsf8lx1r29Q5f5L
         ZXnxHc8Z/84J1TpFncoFrew1EqRcGazCYnT7+pfeCfY65UjyDVb9YQNoRWtOCt4h3lec
         JL3qlCyegLp0BdGDGR+gZ9AVwQCg9iToRtBXXWUZ6PjMjP5de82VXVqbEJ6WsqxnwN3A
         YBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697860148; x=1698464948;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K3HOC/wXeks16fUtvvw3sAzv6UwudNS5m0LmKpkToQg=;
        b=i47Gqfs1Q45rmZe7EycRULPA+lkuS6tpfhVAMzEZnMuJeEU3ZFTc80SHcGOxFHWS5Z
         bfk+zyvsv0kkTjfh9P6FVc/6ViVgDe2svFmdg0zqZ12KaB2wfcy6L5Tf7RYB4AvO7k5t
         kjmK1PyrVocl14jlkqGma76LL/dDumoCNaW97mPwk9b9Cy/LjgjVGjFGUZeMH1xUBFfG
         BnkuCBM3viUL6o7Nk70rjI1cMYTUoxNZK8eqecPZ27Xsj36cPCknZksRYqWpeqQnxdIM
         2orm2bClTHo8pnyGep+eal1Wwpm8vsnD4ApvmPOsWQtYjYpnCYkPFsMhXKXVcgDrUDCq
         XhIQ==
X-Gm-Message-State: AOJu0YxQcq+8zSy/r0PG0qqeyLqR9TxTtSaRIWqcBKKWwMX/UIugNlco
	j+d6J5Yoi9EMKQ0Jr77uXUJfqDtv6PACFQag
X-Google-Smtp-Source: AGHT+IGJAyOZxNEV8Rs+OiURTEmgDSOe5XrHGq2xsQjnf1c5QSTWtiqAs9FG1g60FO5sqtSaPk+blg==
X-Received: by 2002:a05:6a20:a10c:b0:15d:f804:6907 with SMTP id q12-20020a056a20a10c00b0015df8046907mr4107720pzk.0.1697860148285;
        Fri, 20 Oct 2023 20:49:08 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id k26-20020aa7999a000000b006ba2c1336bfsm2278544pfh.180.2023.10.20.20.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 20:49:07 -0700 (PDT)
Date: Sat, 21 Oct 2023 12:49:07 +0900 (JST)
Message-Id: <20231021.124907.1866440680448148505.fujita.tomonori@gmail.com>
To: nmi@metaspace.dk
Cc: andrew@lunn.ch, fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, miguel.ojeda.sandonis@gmail.com,
 tmgross@umich.edu, boqun.feng@gmail.com, wedsonaf@gmail.com,
 benno.lossin@proton.me, greg@kroah.com
Subject: Re: [PATCH net-next v5 1/5] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <87o7gtggyt.fsf@metaspace.dk>
References: <87sf65gpi0.fsf@metaspace.dk>
	<e5109b0f-5fd5-4ae7-91e2-3975e3371ebb@lunn.ch>
	<87o7gtggyt.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Fri, 20 Oct 2023 22:30:49 +0200
"Andreas Hindborg (Samsung)" <nmi@metaspace.dk> wrote:

>>> If this function is called with `u32::MAX` `(*phydev).speed` will become -1. Is that OK?
>>
>> Have you ever seen a Copper Ethernet interface which can do u32:MAX
>> Mbps? Do you think such a thing will ever be possible?
> 
> Probably not. Maybe a dummy device for testing? I don't know if it would
> be OK with a negative value, hence the question. If things break with a
> negative value, it makes sense to force the value into the valid range.
> Make it impossible to break it, instead of relying on nobody ever doing
> things you did not expect.

You can find discussion on this in the previous comments too.


>>> > +    /// Callback for notification of link change.
>>> > +    fn link_change_notify(_dev: &mut Device) {}
>>> 
>>> It is probably an error if these functions are called, and so BUG() would be
>>> appropriate? See the discussion in [1].
>>
>> Do you really want to kill the machine dead, no syncing of the disk,
>> loose everything not yet written to the disk, maybe corrupt the disk
>> etc?
> 
> A WARN then? Benno suggests a compile time error, that is probably a
> better approach. The code should not be called, so I would really want
> to know if that was ever the case.

These functions are never called so I don't think that WARN or
whatever doesn't matter. The api of vtable macro is misleading so I'm
not sure it's worth trying something with the api. I would prefer to
leave this alone until Benno's work.

