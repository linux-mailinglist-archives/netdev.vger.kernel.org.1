Return-Path: <netdev+bounces-44154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF4E7D6B34
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 14:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9976A281126
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 12:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1BF273F2;
	Wed, 25 Oct 2023 12:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Y3D0GZLw"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32CB2D604
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 12:20:53 +0000 (UTC)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875BECE
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 05:20:51 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c523ac38fbso83398141fa.0
        for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 05:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698236450; x=1698841250; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fShXsPgDOgnyfdb+jgOvlSS+wejkoeOfsPohFpEDw2M=;
        b=Y3D0GZLwp4Cxfvy1Vlg/OeQDdgGUtYHcrDj6HSPXVJZ4SrrLtPlh4+8H3kkM+i2QIh
         ydP/1v8jN9h/Ud9iJLWhn95fX2Pu1SacGUlEWMnv70NQ7MTtsI1mbNPBJEALrAuKif5X
         aCuIgEWVfxtgCV3te2QuZw6dpkteIRsNeclEtwqZ3L8Dc0L1Y3DM4qqYJ5aPssi+6Y3p
         65VYkyxIkYnPJTA8dynaQNVvTfXDqwo1sFZ/1URM1gte9GqzoKHaZed70danwvygb1zZ
         4fRMA6Aak3AXCw7yDvmZiN/pBJ9xxugil6YIJBCRktPCbpTELxvleSKr23veew1cU1hR
         smJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698236450; x=1698841250;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fShXsPgDOgnyfdb+jgOvlSS+wejkoeOfsPohFpEDw2M=;
        b=pCLA4qhvEFOc+2IkTmFDyQTQOOALVcdeMq9QsmCK5C6yRUd69XHMxXWXDLaelMHqGU
         fXPb8CzSNoT+ZziI9yXiDQk/oe8TVeko4ybpKCQ1WuVJIb84tYdqtsW1Sym6TkQslGF4
         fIoJMjHHieychZmZmq5jnH0pOupr+nUW9RpLgDgnUqmR9+/ydSg2nZNVdB+/fmUwyXmO
         QnG8fr+PhYYZgUMfrNt4TP3MOVsAYQxDLl3fKsq+UdiwDQ76DNyFdiyEVUpjCirZP9fT
         +Fefqg2nITAGflyrLo3fdauj6wM2gDVxVFKrjdBurSOcQWYEc1V5ot9rBLN45CTlteBi
         3YUw==
X-Gm-Message-State: AOJu0YxCs0DKAnbi6Vq3fCbkbpX3NhvR4bHJZmGzqbFBjJjgvfvUCtW9
	mMza2vYA8n1Qo/7EpekwxiLoMQ==
X-Google-Smtp-Source: AGHT+IEvz4NMxeEHxkZx1Gd99MbaIl8W/GxIxbl+NvOQjffMvlcjF6OL3crDJgL8ZNYvvQYuGz6pSA==
X-Received: by 2002:a05:651c:221c:b0:2c5:1ad0:c318 with SMTP id y28-20020a05651c221c00b002c51ad0c318mr12340683ljq.44.1698236449624;
        Wed, 25 Oct 2023 05:20:49 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id v21-20020a05600c12d500b004081a011c0esm18864853wmd.12.2023.10.25.05.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 05:20:48 -0700 (PDT)
Date: Wed, 25 Oct 2023 14:20:47 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Wojciech Drewek <wojciech.drewek@intel.com>
Cc: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH iwl-next 1/2] i40e: Remove VF MAC types
Message-ID: <ZTkIH68kCzb+4VME@nanopsycho>
References: <20231025103315.1149589-1-ivecera@redhat.com>
 <20231025103315.1149589-2-ivecera@redhat.com>
 <8a8f54a8-1a18-4797-a592-b57bc6fc45c1@intel.com>
 <ZTkHJ6IP4tj3EmCV@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTkHJ6IP4tj3EmCV@nanopsycho>

Wed, Oct 25, 2023 at 02:16:39PM CEST, jiri@resnulli.us wrote:
>Wed, Oct 25, 2023 at 12:48:37PM CEST, wojciech.drewek@intel.com wrote:
>>
>>
>>On 25.10.2023 12:33, Ivan Vecera wrote:
>>> The i40e_hw.mac.type cannot to be equal to I40E_MAC_VF or
>>> I40E_MAC_X722_VF so remove helper i40e_is_vf(), simplify
>>> i40e_adminq_init_regs() and remove enums for these VF MAC types.
>>> 
>>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>>> ---
>>>  drivers/net/ethernet/intel/i40e/i40e_adminq.c | 33 ++++++-------------
>>>  drivers/net/ethernet/intel/i40e/i40e_type.h   |  8 -----
>>>  2 files changed, 10 insertions(+), 31 deletions(-)
>>> 
>>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.c b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
>>> index 29fc46abf690..896c43905309 100644
>>> --- a/drivers/net/ethernet/intel/i40e/i40e_adminq.c
>>> +++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
>>> @@ -17,29 +17,16 @@ static void i40e_resume_aq(struct i40e_hw *hw);
>>>  static void i40e_adminq_init_regs(struct i40e_hw *hw)
>>>  {
>>>  	/* set head and tail registers in our local struct */
>>> -	if (i40e_is_vf(hw)) {
>>> -		hw->aq.asq.tail = I40E_VF_ATQT1;
>>> -		hw->aq.asq.head = I40E_VF_ATQH1;
>>> -		hw->aq.asq.len  = I40E_VF_ATQLEN1;
>>> -		hw->aq.asq.bal  = I40E_VF_ATQBAL1;
>>> -		hw->aq.asq.bah  = I40E_VF_ATQBAH1;
>>> -		hw->aq.arq.tail = I40E_VF_ARQT1;
>>> -		hw->aq.arq.head = I40E_VF_ARQH1;
>>> -		hw->aq.arq.len  = I40E_VF_ARQLEN1;
>>> -		hw->aq.arq.bal  = I40E_VF_ARQBAL1;
>>> -		hw->aq.arq.bah  = I40E_VF_ARQBAH1;
>>
>>What about removing those I40E_VF_* defines?
>>This is their only usage here, right?
>
>Wait, do you suggest to use the values directly? That would be
>wild even for i40e :)

Ah, sec. This is duplicated in
drivers/net/ethernet/intel/iavf/iavf_register.h. That confused me.



>
>
>>
>>> -	} else {
>>> -		hw->aq.asq.tail = I40E_PF_ATQT;
>>> -		hw->aq.asq.head = I40E_PF_ATQH;
>>> -		hw->aq.asq.len  = I40E_PF_ATQLEN;
>>> -		hw->aq.asq.bal  = I40E_PF_ATQBAL;
>>> -		hw->aq.asq.bah  = I40E_PF_ATQBAH;
>>> -		hw->aq.arq.tail = I40E_PF_ARQT;
>>> -		hw->aq.arq.head = I40E_PF_ARQH;
>>> -		hw->aq.arq.len  = I40E_PF_ARQLEN;
>>> -		hw->aq.arq.bal  = I40E_PF_ARQBAL;
>>> -		hw->aq.arq.bah  = I40E_PF_ARQBAH;
>>> -	}
>>> +	hw->aq.asq.tail = I40E_PF_ATQT;
>>> +	hw->aq.asq.head = I40E_PF_ATQH;
>>> +	hw->aq.asq.len  = I40E_PF_ATQLEN;
>>> +	hw->aq.asq.bal  = I40E_PF_ATQBAL;
>>> +	hw->aq.asq.bah  = I40E_PF_ATQBAH;
>>> +	hw->aq.arq.tail = I40E_PF_ARQT;
>>> +	hw->aq.arq.head = I40E_PF_ARQH;
>>> +	hw->aq.arq.len  = I40E_PF_ARQLEN;
>>> +	hw->aq.arq.bal  = I40E_PF_ARQBAL;
>>> +	hw->aq.arq.bah  = I40E_PF_ARQBAH;
>>>  }
>>>  
>>>  /**
>>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
>>> index 9fda0cb6bdbe..7eaf8b013125 100644
>>> --- a/drivers/net/ethernet/intel/i40e/i40e_type.h
>>> +++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
>>> @@ -64,9 +64,7 @@ typedef void (*I40E_ADMINQ_CALLBACK)(struct i40e_hw *, struct i40e_aq_desc *);
>>>  enum i40e_mac_type {
>>>  	I40E_MAC_UNKNOWN = 0,
>>>  	I40E_MAC_XL710,
>>> -	I40E_MAC_VF,
>>>  	I40E_MAC_X722,
>>> -	I40E_MAC_X722_VF,
>>>  	I40E_MAC_GENERIC,
>>>  };
>>>  
>>> @@ -588,12 +586,6 @@ struct i40e_hw {
>>>  	char err_str[16];
>>>  };
>>>  
>>> -static inline bool i40e_is_vf(struct i40e_hw *hw)
>>> -{
>>> -	return (hw->mac.type == I40E_MAC_VF ||
>>> -		hw->mac.type == I40E_MAC_X722_VF);
>>> -}
>>> -
>>>  /**
>>>   * i40e_is_aq_api_ver_ge
>>>   * @hw: pointer to i40e_hw structure
>>

