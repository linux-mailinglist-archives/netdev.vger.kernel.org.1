Return-Path: <netdev+bounces-41786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5407CBE51
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 11:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87572281746
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 09:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABE43D96A;
	Tue, 17 Oct 2023 09:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="PPexVhVa"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E72DC15F
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 09:01:44 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72932124
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 02:01:41 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-32db8924201so1440460f8f.1
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 02:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697533300; x=1698138100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n0ZwSxcglD63mlTmCZgEp9zNaqcuyVBL+a1pqctvEUg=;
        b=PPexVhVaIAM5qUx+Y8sxnj/6/ZCxwnbOXXNuFODKiYlo8dx4YTF2/9rFjZ0sdja9t+
         973L/2Reyr+iExOy4Eirp3peys9AcbDFwgvj7uTS5rwmAcGx89P6Xxm14fZFvIqiWwoA
         Oc+RFgDmqYGOCqxBhK93ZWmIFZzS7XLgAU5MwCfw3cYWamqWzPjBQwX5missbGm6pP6z
         7wVFe04t+zwlk0NIJrwKA6eY7qOQ3sShJogPKObRppwgLxD48U5m27HWOWFj97fwQ93h
         +EFSF7hRhDhbDv2d1aufbyMosECtFXZnzD0CY4GwZQ3VBlq9o9kHrOabMcJepdacooFf
         D98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697533300; x=1698138100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n0ZwSxcglD63mlTmCZgEp9zNaqcuyVBL+a1pqctvEUg=;
        b=gL5jp0rlI8tI6sWom7dYmYfRzWehBga27bZyWvu28XYpm4K5cdu5VWxH4yfh3QxkM5
         u8ex7HaX31a37O6sltPstEzUR7JwJELdqq7aGN3ZR7ytCqfdj0R5r6vpgn6Uh0Tg2ibQ
         xu0VolPaTaAWy3TG4cSxpa4iAxTJrClvtRJnUltavgndTAGJEEdl5vywB+x4S3kBV7ad
         yKrVozQOWHu+vIyA4vVoB87roKTKAuVeQvwHJ5owQwQe2mKJerjvajsrN3kMJY9j9c+f
         QmlYkD0iHdecPgxcMUh5jCz31JpkBqqFs4xrUoNzTcbh8Vz5oaxyGDGF+oPp+Q9DYu1p
         zweA==
X-Gm-Message-State: AOJu0YzGe+dpyqixFNFFHCE2ea80EeecSD1bU+7zuKAFn9YQY7U4vlYN
	vPmeRHBL9Mh0u/Ur5+skZJ0loA==
X-Google-Smtp-Source: AGHT+IF5WzTohtQMpALIknd58a9nZY7AlTTTgEMp4caFdIhtlHk0o8BsyBUOrFNhAS5GQVSEORRBtQ==
X-Received: by 2002:a5d:5347:0:b0:32d:b654:894b with SMTP id t7-20020a5d5347000000b0032db654894bmr1227002wrv.32.1697533299879;
        Tue, 17 Oct 2023 02:01:39 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id n2-20020a5d51c2000000b0032da4f70756sm1208902wrv.5.2023.10.17.02.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 02:01:39 -0700 (PDT)
Date: Tue, 17 Oct 2023 11:01:38 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, linux-pci@vger.kernel.org, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	bhelgaas@google.com, alex.williamson@redhat.com, lukas@wunner.de,
	petrm@nvidia.com, jiri@nvidia.com, mlxsw@nvidia.com
Subject: Re: [RFC PATCH net-next 02/12] devlink: Hold a reference on parent
 device
Message-ID: <ZS5Nclma7BXGNX3F@nanopsycho>
References: <20231017074257.3389177-1-idosch@nvidia.com>
 <20231017074257.3389177-3-idosch@nvidia.com>
 <ZS4+InoncFqPVW72@nanopsycho>
 <ZS5BrH1AOVJyt6ac@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS5BrH1AOVJyt6ac@shredder>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Tue, Oct 17, 2023 at 10:11:24AM CEST, idosch@nvidia.com wrote:
>On Tue, Oct 17, 2023 at 09:56:18AM +0200, Jiri Pirko wrote:
>> Tue, Oct 17, 2023 at 09:42:47AM CEST, idosch@nvidia.com wrote:
>> >Each devlink instance is associated with a parent device and a pointer
>> >to this device is stored in the devlink structure, but devlink does not
>> >hold a reference on this device.
>> >
>> >This is going to be a problem in the next patch where - among other
>> >things - devlink will acquire the device lock during netns dismantle,
>> >before the reload operation. Since netns dismantle is performed
>> >asynchronously and since a reference is not held on the parent device,
>> >it will be possible to hit a use-after-free.
>> >
>> >Prepare for the upcoming change by holding a reference on the parent
>> >device.
>> >
>> 
>> Just a note, I'm currently pushing the same patch as a part
>> of my patchset:
>> https://lore.kernel.org/all/20231013121029.353351-4-jiri@resnulli.us/
>
>Then you probably need patch #1 as well:
>
>https://lore.kernel.org/netdev/20231017074257.3389177-2-idosch@nvidia.com/

Correct.

