Return-Path: <netdev+bounces-43869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E15A57D5087
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 15:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E04D91C20BC6
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 13:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1396E273ED;
	Tue, 24 Oct 2023 13:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="2sD6BBIQ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A021804A
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 13:00:37 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF1010C3
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 06:00:34 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53db360294fso6963382a12.3
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 06:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698152432; x=1698757232; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWgZj0jWXyKIUpIqseNDFQ+Z3Ajt56Y9J6kThz0DfLU=;
        b=2sD6BBIQO1lj4Kwx720Zfg3rgFovVh7nNSRRwmuXUB3v5G+YauzDqwDTC1LmFpghgH
         /IAI3ZuZHVMQo4sTKradRg0zgX2lt1zERwEI7uCMhoqKExPfeZxnAdA9OAQ7Vdr6JpcU
         QjLNvOc/+CZDjY6qPmJsWxpxSkUcTX7I4hDvAHxzrhRN05LzgVFIR+pA+SMEKo+BlFdb
         3sl/H1GmcwAhntF90SsdLNrhWhWV9htkV2irNgOvi71rtKiUijJ24h0hoFB01/FH94vO
         xSbgofR44bkZsrJZOTYSrZOLwp0ITuwOwtf/pLro5/2xQAPOoNZkCzWZoJRPaBUJws3L
         ZadA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698152432; x=1698757232;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWgZj0jWXyKIUpIqseNDFQ+Z3Ajt56Y9J6kThz0DfLU=;
        b=TWI4BOYm2mea8TeQyZrnbgktNh9RYYueyPAT6MGoL6jd/TsUp7pSILrOY3xQzC+Ew9
         sTV0kMW45zkOiMDcPbmV6cOMCD4mIn8yKRoLc2WeJjj4fyNVBn9eiJXnlLexmcWHKVJp
         xtGk+oKHJU2ZkO3IhThnG89eqS8wRKpBf3HitJO6V+YbDWHYGbCGuc6DG9Ru2v991PKw
         5qwhyPjEbMI5xf9kixMSudFM5GpRbx9aEpcySCnHwHWHIXpSHBUXrnMG5DRsnrbMLWKT
         oOXvQO/OB1X5T59HvSVmYwfsTBX8u7KAoB6ktbL/m8m7gc/OYBH/3FbtklObSjdBzk2S
         mCEw==
X-Gm-Message-State: AOJu0YxODyKPR+mmZ2xHxAf/ylDU8IFcSgXdi/mtQU+hDEg9Xaa9gw9H
	JyJNOXIjhDF3go68NxJK0k7iFQ==
X-Google-Smtp-Source: AGHT+IEzcpYTuCTOHF/4/6Ur1ISFMPTfgKZaV6/zztDjAlr47wbdwfa+ojve+Wi/F7riNzmSUNX+5g==
X-Received: by 2002:a50:d603:0:b0:53e:6624:5aeb with SMTP id x3-20020a50d603000000b0053e66245aebmr9243046edi.11.1698152432557;
        Tue, 24 Oct 2023 06:00:32 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id h28-20020a50cddc000000b0053e589016a7sm7980698edj.16.2023.10.24.06.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 06:00:31 -0700 (PDT)
Date: Tue, 24 Oct 2023 15:00:30 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH net-next 1/2] i40e: Do not call devlink_port_type_clear()
Message-ID: <ZTe/7nfMmS+6KhrE@nanopsycho>
References: <20231024125109.844045-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024125109.844045-1-ivecera@redhat.com>

Tue, Oct 24, 2023 at 02:51:08PM CEST, ivecera@redhat.com wrote:
>Do not call devlink_port_type_clear() prior devlink port unregister
>and let devlink core to take care about it.
>
>Reproducer:
>[root@host ~]# rmmod i40e
>[ 4539.964699] i40e 0000:02:00.0: devlink port type for port 0 cleared without a software interface reference, device type not supported by the kernel?
>[ 4540.319811] i40e 0000:02:00.1: devlink port type for port 1 cleared without a software interface reference, device type not supported by the kernel?
>
>Fixes: 9e479d64dc58 ("i40e: Add initial devlink support")
>Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Ivan, I see that even if we have checks and warnings, it is not enough :)

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Btw, some (even brief) cover letter for patchset would be nice.

