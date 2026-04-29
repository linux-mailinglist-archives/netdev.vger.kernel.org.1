Return-Path: <netdev+bounces-282148-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJfXE55L8Wn5fgEAu9opvQ
	(envelope-from <netdev+bounces-282148-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 02:06:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D56EF48DB53
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 02:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F075330071E0
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 00:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D430E40DFCD;
	Wed, 29 Apr 2026 00:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="H8epW2Xq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f228.google.com (mail-dy1-f228.google.com [74.125.82.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923C0173
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 00:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777421209; cv=none; b=ubmUdZMBSPcDLVKANQWmZPSamBzIenvKCsq3E5Z9iC74np8inEv2LTsn8lQEJu02/Z7PfUAA087aIXhC46o0xQj9XcmeoxxNwSyVsfek1QmU7t4VeI49n3tVFuf7hwkxM6lfW+9qD2bOojE4fiTS7rob0x9Z9zlonZ0h+2uPcpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777421209; c=relaxed/simple;
	bh=v/ACVyc24EjyoVDtAC6ZGEk5Ry47KrUgI6w16Ckhei8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F9/aOZoZT8MCHzdn8uio3nTN4Yd4X/NqtXTtXqZyUZru+uMrof1sIFISU+szJDP2pbTYmhZduJzV9a91/l3QOhuZni2ByZFMQmWDM1jGWAzYsBuxDKZVM2EQ8EfSa/PvnkvF8RJc9CPLQFW3A10TrFnoa7ZCBlwIxt89LlpxP3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=H8epW2Xq; arc=none smtp.client-ip=74.125.82.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dy1-f228.google.com with SMTP id 5a478bee46e88-2e221a71e19so12097900eec.0
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 17:06:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777421208; x=1778026008;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9WYyavj4arH8zsw8ZKRvSaiTvGJ49mfikSYqnddFlmc=;
        b=O/KJ3JKmww4sQ0CsHZJBbBWGD+feIywFgbwuas6/8Sf7KqkLSRB+O87u48oXP+Q+6v
         iipAZB+GJpx7WNuPHcwfkppvw9LAQNwmC8CSVCazrEzB/oPRX3RegEo9zoCxNnn6dL2V
         tC5ULHfsBbX+lyYaSetZp45uesov2KLaJjxBq6Y+GntlRSfYyTptzgmXpMpm8y6JmV81
         /m/ESGMt8yDMhX8b4+8w7VSgpx2uNEcwdqCwuJFqRruAICYijxHdAgD4RA5n9QqPvnUe
         5zijur+tIvhWHKImmRo+Vn56V1O8A3t+OUZSLV7envgmMyn+MWGOuFFB8u+aDfgs3nrc
         zC8w==
X-Forwarded-Encrypted: i=1; AFNElJ+RVLPXNRP5qDaCcYJQOIOHVkjEdNpzDBy84GuLQVa5u2TwZFAJWYGNa5irx40rKYulPwkmucc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv3U6DTwtaw+pdiTwH4C7GzdS/Mw7bSoGJwoemiJfzOMNtFlwQ
	dOPtne/voLu8WbCx770nSYde9qFJYe7wALccQ6VC0Y/VSasPuFY3eBxGWwmPvBtNBCm6Pr/Eoir
	UVbZ0/Wd5qbbjGmaGNPdGjLZ7QjpRhNE+w0UzhP59gpOH3g6mevavciPgTtwfBRoh3GFSdEyZek
	XhbUNfSgWKpqv/xO1JbvZEM4uYL/WC3PqZUMBnphBe88jubwwkjdubL2W8UVVsGtsHsh0jsMOox
	bXiazJzqHV8wrUW
X-Gm-Gg: AeBDieu5m7NUd7MJFnFuQbgfPAMXc3P+L/83CQcyXMVO7TsO2ER5Y8oBlQ8rRgJQ3Hr
	O3FF/Z5RfZ2m2cdoiRiRyLmJV4Xuhws9B6NS4qQXCdICxEo7ESVic8hrFAWYqu62gISruje6wxd
	vWKCsViInkoLgX1tNbsp332p/KcJ0PCCs6D7UlsL/ZdKHmtcedfNl2IgJZQVim7gjQkovmYQf++
	r/GXwEPTRMMUeBGhyb33iZC3tHHx7pWwrUtbWSBkxjSIIAeGLhPqqNn4rQtF3Znwkw09QoU2qmY
	Uws7w3ezbwIl2+elUm5I8zXVDX/naQhYnOW7O4baw400X8ljtbR6Lq8InNWpLm5WXBokkzB6DCL
	+v2wLF8IpPkiQpRRXIn4BTY3KkspZfhs7gp5RIImDOP+T3QXnLLNu6dZ71N3sjCWRYY9Aj79B/d
	E+8WG9mjAEKXJJuzIdBnEHUXVrLlonHQ0+yEWkFvCO3EAu3QDlpg9KTqzc42sW/bT6TWg3q3qq
X-Received: by 2002:a05:7300:dc8c:b0:2ea:e93a:ff9b with SMTP id 5a478bee46e88-2ed0a08581emr2476655eec.13.1777421207436;
        Tue, 28 Apr 2026 17:06:47 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2ed1c06a6c9sm34526eec.22.2026.04.28.17.06.47
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2026 17:06:47 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-79895ffb315so79662327b3.2
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 17:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1777421206; x=1778026006; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9WYyavj4arH8zsw8ZKRvSaiTvGJ49mfikSYqnddFlmc=;
        b=H8epW2XqDzfWRUfKLsGRnGUiMQuT1W2545Y4rCNhTcLW4pPN4UlQt23gs3d7AR5B6X
         UfpefKTxiCC4pf03G7kmQs5ZJnYhXBbTl3cwrZq+JvLJDXX3e2WyWawhBFcYedE16uF7
         N330cZsKnV098PfqSqpA08085hQHsyQmJ30Hg=
X-Forwarded-Encrypted: i=1; AFNElJ9okMNw6NIxzNdkz7OvSvQZQYejF79XSx2dgR8n9mNyvM3Ntm8zSnuD314yugH3UvrwrmKE0Pk=@vger.kernel.org
X-Received: by 2002:a05:690e:d8f:b0:654:1261:8b86 with SMTP id 956f58d0204a3-65beed6c098mr5142883d50.2.1777421205985;
        Tue, 28 Apr 2026 17:06:45 -0700 (PDT)
X-Received: by 2002:a05:690e:d8f:b0:654:1261:8b86 with SMTP id 956f58d0204a3-65beed6c098mr5142843d50.2.1777421205533;
        Tue, 28 Apr 2026 17:06:45 -0700 (PDT)
Received: from [172.16.1.137] (107-214-104-235.lightspeed.irvnca.sbcglobal.net. [107.214.104.235])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65bff4c2a40sm464126d50.2.2026.04.28.17.06.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 17:06:45 -0700 (PDT)
Message-ID: <80fc6f77-3da6-4f00-ab2a-f99ab218bf3e@broadcom.com>
Date: Tue, 28 Apr 2026 17:06:37 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Keep PHY link during WoL sleep cycle
To: Justin Chen <justin.chen@broadcom.com>, netdev@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch, florian.fainelli@broadcom.com
References: <20260428220858.2076469-1-justin.chen@broadcom.com>
Content-Language: en-US
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
In-Reply-To: <20260428220858.2076469-1-justin.chen@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: D56EF48DB53
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-282148-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[florian.fainelli@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]



On 4/28/2026 3:08 PM, Justin Chen wrote:
> First we divide the init/deinit path to allow for a partial init/deinit
> during a sleep cycle. We also remove some unnecessary small functions at
> the same time.
> 
> Then we modify the suspend and resume path to allow for a partial bring
> down and bring up. This allow us to keep the PHY link up and to resume
> network traffic much quicker.

Since you are going to re-submit this should be prefixed with 
"net-next", thanks!
-- 
Florian


