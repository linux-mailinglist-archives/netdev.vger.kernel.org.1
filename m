Return-Path: <netdev+bounces-268257-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PQIAKJWuGmKcAEAu9opvQ
	(envelope-from <netdev+bounces-268257-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 20:14:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81AE329F9E5
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 20:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 63B253013267
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 19:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B48D33C186;
	Mon, 16 Mar 2026 19:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VJQT/MGw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6235133AD91
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 19:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773688478; cv=none; b=Ki/lyeMBaKlsjPNXgrKtkI/NvzPABV8Tt/fzPfAgeOaksWmp1t+EfyXIhMWrgnDFK9zNmO4tU13H51tm11fWqNS/XmagVoFSgHZHqcsswVdHNgQ0Qsl1vsm5HSNub1rpSVMx2jvBVgyf3xIqWUQhwCwyTU/k9kzj4mq0BDVDGgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773688478; c=relaxed/simple;
	bh=1gjOHuNaU6iBUwDIlVmchra+F7WLnSNkvcXWiMmO9uo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T7eIG6Gp/1hrehxpKM2tK10Vbxj8DYInLAlcTk2yADGhmpNlOvChD8oYiZ2l1qjpUqoyVzjoMHo6E68QVcIt81QDNCDFpHHpX4rASs41QciuV3Y53WrVExO3R3MlsK+98t8qnd2y7GrILZjzBPZU8K+7PjVjXZIBnOZ8JraaOyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VJQT/MGw; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2b062069f80so4242275ad.0
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 12:14:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773688477; x=1774293277;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lZk1aQmRWSmQkE953YPkcE7wWeYRXRByCIMhXjOtW4c=;
        b=qSxqzUrnqcHeYTdHThZAMlpbC6JqYdgcezNl3xigxC17H9WB9DM+8PpQVEA6a+fnPS
         PIVQPWAVVxgrIAY8uRKPawue8KRF6qTJoiD6fOSkruP/KrcglFFutnur5b4C3yuqS3Xf
         pre1RrtDO5VnmJ3uL0gCb3yLhyuRuFE9Izc9cg/HXQYqIP1DCJ5Ec/TXAnr/HJUEP6Hx
         LNL4jP5NelV1RD3gmor8AO0a5YmxIufQLZCYAa/E0xSVcNnfWAQuidd7PqZkiEnPF3yE
         BwbrhG9KbPMnf5Dpa9Iz6gtcd+LG2djPfe1IobVe6zT4jOBuUvX7j3bztTa1iGl6mGR6
         tVUA==
X-Forwarded-Encrypted: i=1; AJvYcCVs4ALKznwZ3cCaKw/zb4jqcCYFUi9r/AmUBn4nuvo3r7Qyr+/NgFv+qmlDew92bVxAGNvH54E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJU+o7NlUX5jE5B0aFBUvA08da6dt/hKdfVutPCFZpIOMPNJdB
	a2HpkAcdwe0oi6pxjpPPlNZjZL3Z2Pp6phMVNaIcpxnzsu0SYZouVTbA0onTYDtzL7Fjx9O6DCK
	MKjOLZRofZx9tUmgPIAMQPbV1lOgwuHctvTanpNxWidjwHJ+hnCvfd+dMSv7Di/v4US452b/TRb
	c+3Hg3imGedWNPm1iH1QsG8T/Gz6xHZTOLaNsQuQUOn5/AQhlH3NL8E1SjyLEY3/l20tyVkyVRH
	CoeCoDyUsHDVQL6
X-Gm-Gg: ATEYQzzbBme1Jg1v1M5UIeVqKiNomm3dq0uHvvw2xHSH7zSmO5SmdjVZ3vEcbo4KDWA
	Y0vc5dzpAwRFXnB3z5SKXfR0kTYUpS4Iu7YbdrayTfwlBKKWh+QfT8r+XnL7dOsJmFwy06rYivm
	YhJVnzC+iquZksAHRQ50MC08XsnbcW0tTSn47vxZG0DTIbRY8J/LsTZbp9bAkzshL7L3GxiSGQy
	/HRq1DkfRKWLFdmvsiJJQUh3CsbWo33vojG+YHqukAqVibIh59pWI2NRf32gZP7dyg15Heh+BXB
	svhFK9JpJlYOKNFLgfK/pZekh5jdioXgZq767ngDK/FM1yaEZC5Iyh1FPGhEzg+JcP79OjkttyO
	JtQ9ElxQ0tzkoh2JtE9OmdBPx6u5Id6xFvZ/pDpu4IqDAtx4Rpz5n7OIY792dkCUqwpZXw1nK4J
	s9JKf1Mg9KiA7zp+JmOyy+Jpl9JcxD9dnwMbmF1RuuEQSGjUs3si7znKJKYWKssw==
X-Received: by 2002:a17:903:38c5:b0:2ae:567f:fd7e with SMTP id d9443c01a7336-2aeca9a98d3mr150382105ad.4.1773688476356;
        Mon, 16 Mar 2026 12:14:36 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-63.dlp.protect.broadcom.com. [144.49.247.63])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2b064ea1885sm132145ad.45.2026.03.16.12.14.35
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Mar 2026 12:14:36 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cb52a9c0eeso5160696285a.2
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 12:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773688475; x=1774293275; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lZk1aQmRWSmQkE953YPkcE7wWeYRXRByCIMhXjOtW4c=;
        b=VJQT/MGw+RfP8MTaG4UDZRgaBojOSGZFxZplC2PqX8LX3gd14XtglxGIATc+Gqyylu
         NWdef2wywsGNalR/HXsF+q0fBSnvKzq6fpJO8mPlJVoxm4J+e0SSxmc62gQ5wiwIpEKS
         2dXFK4KDnkrPrST0ERo6CFR+NAlqZcCxHFaoo=
X-Forwarded-Encrypted: i=1; AJvYcCUSXS7hrUXkRm8BdJI2Qp1X2WCCvnBIlEzo0bouHRj9Rr3iYeJ9z2rQ9Pn7uVQaCu+FEwyRF1c=@vger.kernel.org
X-Received: by 2002:a05:620a:4489:b0:8cb:3df5:4b6b with SMTP id af79cd13be357-8cdb5bae99emr1819394485a.61.1773688474995;
        Mon, 16 Mar 2026 12:14:34 -0700 (PDT)
X-Received: by 2002:a05:620a:4489:b0:8cb:3df5:4b6b with SMTP id af79cd13be357-8cdb5bae99emr1819390685a.61.1773688474456;
        Mon, 16 Mar 2026 12:14:34 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cdb2cff8a2sm952943985a.41.2026.03.16.12.14.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 12:14:33 -0700 (PDT)
Message-ID: <4176a53e-6eba-4cac-934a-f530a0e2025a@broadcom.com>
Date: Mon, 16 Mar 2026 12:14:31 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] net: bcmasp: fix double free of WoL irq
To: justin.chen@broadcom.com, netdev@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com, horms@kernel.org,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch
References: <20260316180202.3371477-1-justin.chen@broadcom.com>
 <20260316180202.3371477-2-justin.chen@broadcom.com>
Content-Language: en-US, fr-FR
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20260316180202.3371477-2-justin.chen@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268257-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[florian.fainelli@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 81AE329F9E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/16/26 11:02, justin.chen@broadcom.com wrote:
> From: Justin Chen <justin.chen@broadcom.com>
> 
> We do not need to free wol_irq since it was instantiated with
> devm_request_irq(). So devres will free for us.
> 
> Fixes: a2f0751206b0 ("net: bcmasp: Add support for WoL magic packet")
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

