Return-Path: <netdev+bounces-26627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA74D7786FA
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 07:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CCD0281F90
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 05:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C151102;
	Fri, 11 Aug 2023 05:28:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3253710F1
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 05:28:27 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C216E76
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 22:28:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dDkLHdcjkJ/ejhLyedYEcqJ4MsOfaZOBQMAF5TLGNYWsPjJIIpf09LORjEcRXhj2ItJ4V//ZKYiM9HSakx3oJxpuHOEMg2qbhVUZ1eS4W7i4iIotiSA/r7W6qHuukHYi7cOjDRUkPtYXe+dRNyPiirz19d8IT8eCi+DUrHVKlWw+WdNweG27bjYNaB6DIxVirfiRMkJoJnSQ0d9yzutd7ib985KHcPipbZFcfJ0MaGWEuCY0jIVZ9tFDp1MECgko/P+hI80yND0tJCTJDbMAg7YQ13IQFtj4LhbWPuG1BVCg9f/ebIYT8mAb4WsxohFmiN5WloxbGw0+j3RbznWtMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kM7sT6U/bDKQZak5s873zFZnlzKvAwf0fxh7noujANg=;
 b=ceSoLsGuFLdJ/+5I1T46AvEIdL0sLIMWV74ODjCMJzqOAfbsDxG4WX0pXsZ/WrZsqxbiMi1Hu6bVuoH1eLeSIcAzRXw/unzdWyzcYXvk5wDirwXb8tXOAUCWTVFFqK/OvIhW2wXebuO8F7jEZvG7oJa+RekyF+MifwVwqZAlO+xCEwwQaI5sajVRCB3BTUNIn3iL+Qd+ftmk8gSfGBx6dr/rq8oXhLPMoOmRnx1U7KAqRaDhTcY7R3QUX6jIwEpmfWoJCGWhd1O9tgLoHlIskAzvjtOQYyWLsOUuhxJE8oWPYsCNGPEC3EhVJbNeWX5lTAXCc1HcHXyhaJWccOT3hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kM7sT6U/bDKQZak5s873zFZnlzKvAwf0fxh7noujANg=;
 b=uOyaEknCQItt0KRk+5f54iG05OpRoVoDuxpDJFiYKw9KqSsAYAgdVcxviS7p08N5vYhzMmWYzDqSE+wY/edMQM/AjFFY6PLkwOx36gLDCYuur2T+4ajrWzcURzPNutf4wpLu8SoH5q7Zl8Cey+bIJ8lWCYlW+Xtz2vsyygJyqXMsTQq5CAD1/VII8ovkpGR9a0ErPiKIzuTRwIlACzqSViqFZYvKlBiC56JZcbBsSVz2syodrpu/DcQOgtZZupv3GserNIata9pGK+G9FvN3egRZoXYVGK2EGou/zMkfKeycOS8ZBarwHV7pGvMWuNgo9DO7NkNETWl1Ij02Jg4Zdg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CH2PR12MB4875.namprd12.prod.outlook.com (2603:10b6:610:35::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 05:28:25 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::f55b:c44f:74a7:7056]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::f55b:c44f:74a7:7056%4]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 05:28:25 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, Aurelien Aptel <aaptel@nvidia.com>, Shai
 Malin <smalin@nvidia.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, Boris Pismenny
	<borisp@nvidia.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "aurelien.aptel@gmail.com"
	<aurelien.aptel@gmail.com>, "hch@lst.de" <hch@lst.de>, "axboe@fb.com"
	<axboe@fb.com>, "malin1024@gmail.com" <malin1024@gmail.com>, Or Gerlitz
	<ogerlitz@nvidia.com>, Yoray Zack <yorayz@nvidia.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Gal Shalom
	<galshalom@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
	"kbusch@kernel.org" <kbusch@kernel.org>
Subject: Re: [PATCH v12 07/26] nvme-tcp: Add DDP offload control path
Thread-Topic: [PATCH v12 07/26] nvme-tcp: Add DDP offload control path
Thread-Index: AQHZtNxNA/xtp5K1mUmqPygHvione6/U1S0AgAzqawCAAv/7AA==
Date: Fri, 11 Aug 2023 05:28:24 +0000
Message-ID: <d439964b-1544-f37a-6ab4-ec1fb4cd0d9d@nvidia.com>
References: <20230712161513.134860-1-aaptel@nvidia.com>
 <20230712161513.134860-8-aaptel@nvidia.com>
 <8a4ccb05-b9c5-fd45-69cb-c531fd017941@nvidia.com>
 <2ae6c96b-2b05-583e-55bd-2d20133b9b37@grimberg.me>
In-Reply-To: <2ae6c96b-2b05-583e-55bd-2d20133b9b37@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CH2PR12MB4875:EE_
x-ms-office365-filtering-correlation-id: c87ba92d-ff24-4473-d2b1-08db9a2bc8e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 3yfAzCUcgQjlWnRlxckGPFtp64rcz1WZzlMijlMtnklKJduIr2jvxE8zYTfnWmQCp7wa08/XMw9h+UK5hyqv0xkwZSpW3vzE1ideMfDXNywF1svPXK/8m9BQJyb0+wXfrIn8mYZghCgu4lTEfriwZdtpC7Bfvsi1lLvgzCs85eK+QnTR6ZuMIKpNu02MacJd4VPLvrwAszgdKRuIbiVe2HfYZK7XQFrI7b8mZha++6yBDT0bX+1JFgZLIEfKf6s3FqMtU0Ni4Riw+uFWkVfhxx191DuGwDRChy70yRzjZvO31oIu2AuMFOyaQAtbnlMMyViv8NI6U30GazzgoINxKH0xkG/JZY6xE8pi+cFpOaj7y6cbNUp1r5ymv8dh/i2syA6JI/7HKQsA6VW3GRVKGQ+cKEEAOmj1iHYiGT6DH3DiWZzUpkgAFWwj+K9HzcaWwEpojkqzI8o9NKGExGRLPFvy85uDctqhyp9etWHvMGOSFSYRvqoUnOEjGF+WtUCxHbHg/6gyxtLsG1r4z6uIOkM/9TzRM5IHYMis9qlmOyfwgUc4vytnWyg1rAIx+RlewkSd2z80diOKG2z7c16dN9NyoD4mhgXT1WBOf7bTnr+UckWa9G7K5kmoLYiDFV57lHZGod1cUqb7RMUtHD0AJMozlakuwZAtWCPHMiexMCWCueLhjRSSV1ptyjh7wLkz
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(136003)(346002)(366004)(39860400002)(1800799006)(186006)(451199021)(36756003)(86362001)(31696002)(38070700005)(122000001)(6486002)(71200400001)(110136005)(54906003)(26005)(53546011)(6512007)(6506007)(316002)(478600001)(41300700001)(2616005)(38100700002)(8676002)(8936002)(5660300002)(31686004)(91956017)(76116006)(7416002)(66946007)(64756008)(4326008)(66556008)(2906002)(6636002)(66446008)(66476007)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZmZDeU9uaHZMYXU1dUFnNUducEczSTJ5djBnaXN4QnhCTm43R1cvU2k4Yisz?=
 =?utf-8?B?UWMvWEllWDcrcmZZb3Y1Tkp2M3FmRWloWlluOTFVdFJkc2xDZkE4bzV3dFo3?=
 =?utf-8?B?WFBSMThpWU9tTTJKY2lRQnBUMEJPUEdIalZWZlN1QlFzNG83dlAxRVhlRXA3?=
 =?utf-8?B?N1N2L2VGb3VRU3RhNUZQTHNFNzRVSGhTd2FJVGd4WmNkK3MycWF0V0I3UXQ2?=
 =?utf-8?B?ODVTNVNUV0U1Wi93OEk5MjBiamFoVmtpcFExM2lQeFVtQktLdHZhNHcrQmcr?=
 =?utf-8?B?V1V5bElqM2hqQjFIUXhoTlhmWnlJVlRoem1wRWViSzBVVGx6cHVXckZycGVY?=
 =?utf-8?B?eUdhZDlCTUt0M0psZ0ljcTZhSVZhcDZXZVU5YkZVSkc0c0pTSUxmeDV0Mzc5?=
 =?utf-8?B?SnI0cVhYbnh2dnFZL1FPcDVxQmFDWjV3MDhUZ3NXc29vRVZzMm02Q2tXZ2FH?=
 =?utf-8?B?c0hRbVU5cmNvQm9tYzNaYVEydnh2dWhhaVI1c0NTbkh2Q3JYODF0c0hlZ2tu?=
 =?utf-8?B?enM0dGVZSEw5YlhwcXZUaW1tSENqZ0Y5alFtWUFKT2UzVzNFa0YrdkFtcWVx?=
 =?utf-8?B?aURJN3dBY2ptOVhDQzIraWtRQ0hPVDRrdjcwZy9vMVl1aC9QdDhxSWR0Y0Zs?=
 =?utf-8?B?OUJic3hMSm9hcktmRFZKUGNnczRwY2JsR2FLU0ZqMklIelA3Sk8zdVU2TDd5?=
 =?utf-8?B?NTNpSEN1cGgyZHZNR2hJQ2o1aEsxRDUxYjJPd1hmQlJ3b1pLZWtURG42SHVS?=
 =?utf-8?B?ci85SG15bUI1L0t6cGxIemZEUWdWaitPYWNQYWhnQXEwdWZxWEtpMFA5akJj?=
 =?utf-8?B?ZmxSOFFKcG1WMmw2Rm9BdGFPaGkyZ0dYTTQ0UDdnRGxmODlCYjBteW9kUFpR?=
 =?utf-8?B?ZlYwd2REK05SMGZsTllxZ2FTTEZ0SnJ3bUtYK0RiZE1pSnJyaW9TN0JIQjRE?=
 =?utf-8?B?akZIS2dvbUJRRWpkbXJLRndtRUtIZit5YzNna3FicWxyTFZVTGNNcGkzVzhS?=
 =?utf-8?B?N3dkclNIbFRTUXhQV3BCWDhmQnlab1BtM2FLRFdLK2xuSHhKY3hoWjQ0UjVE?=
 =?utf-8?B?R3VOZ0JCYWVmdTZMWnlkZkI2a0xyZklURW5zUWVYYzE0eUphMEM2MlV3VDgr?=
 =?utf-8?B?T1ZMMERHbTF4MXJOQWN2aFJvUzNWSjVOZStNMERiV0FNVjNrcjc3OXEvREtF?=
 =?utf-8?B?OE5yVkNEUkkydE12SUJWc2haYVhMZFQ3Y3RXaTZwd01ubTMwNFhZUHpaYVpE?=
 =?utf-8?B?eGVSUXZ4eXN3QjFoZmswcnNLejFldHZPOUZrVlNPb2VXY2dYMC9NSFd4WVNM?=
 =?utf-8?B?OXM4S1AwN3dMTFo1TUpEY1pvV21TWmo4NkNaVkxacGRXTVdqNTBRRE1EREk4?=
 =?utf-8?B?RHlvK0lXd211K1J1a2Q5SXdpbG1VbUFrTHRPQk1jRDhSYmJ1REJuNzhnQWtM?=
 =?utf-8?B?MkRDWWlzVStQdlZMaXJUVTYrbXk4eXlocDFKc2V4RmZJMGZFRlVMZU15S3RV?=
 =?utf-8?B?R3lhUVU5YldrMmJGVWs5ME4wdnlnZDlUbEJLV0tIakpoMzM1WjhrNU16KzZk?=
 =?utf-8?B?ZlNJWVB4b0tBcjhuM2MzalYyZjNqQ3N5ZkJHNFVza2FCcVRDakp6TCtyKzhH?=
 =?utf-8?B?SHdDTHErOERiMDBUL01ubHhtZEhpUjZvUDZFUWJ5QjBjeGZIc01pMEtPTndx?=
 =?utf-8?B?c1dHeS81NTBOS1plNDNMNFIvUDFrUWZKVU1QVzByZU0xalVGZWc2WXVveURl?=
 =?utf-8?B?bEU3d3ZYdTkzUUNXV0Jyc25zV3R6OHFHVFJ3S2lRdkpZUXErSXl5SHNqMURx?=
 =?utf-8?B?ZHpmYTZhbFpWTVFlR0E1c2JjQUhFbDNvcE9MOHZOMzMwbUZYektmNUlNS3Z4?=
 =?utf-8?B?d09Eb0g5R1JoQ012OHpRcGxiWTYraFRrYzh3YkFFZ2RKeHhDNDhjSjQxbjh0?=
 =?utf-8?B?SGtENGVVdEhMRnJtZVZ3VDVnUXhDUENYcmxYa2RqaGlJNDVMV2xGSUZQVmdk?=
 =?utf-8?B?WS8raFVhOVhCZldlOS9uOGRPbWQ2bElkcDQ5bFFkeTZoV1VXaXVUSm10R0Y3?=
 =?utf-8?B?T0ZmS3BLcU95SjExL1RNbVpkVU92TGRHbFUwY3NNSG9XVFpSaUxrcjNDbEI3?=
 =?utf-8?Q?X1t7T6bKNmD+QEPv4QaqWQJJW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2248ABE6293F5D4EA939BC12475566F9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c87ba92d-ff24-4473-d2b1-08db9a2bc8e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2023 05:28:24.7443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sY0dyVl0JIbzNCTzxKr+8VEWZIhDx80PdIX7Bnr63ab6Iz838yHNZuclmnpYVrS4hJEe67VPu+umE8qZKd+g5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4875
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

T24gOC85LzIwMjMgMTI6MzkgQU0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6DQo+IA0KPiANCj4gT24g
OC8xLzIzIDA1OjI1LCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+PiBPbiA3LzEyLzIzIDA5
OjE0LCBBdXJlbGllbiBBcHRlbCB3cm90ZToNCj4+PiBGcm9tOiBCb3JpcyBQaXNtZW5ueSA8Ym9y
aXNwQG52aWRpYS5jb20+DQo+Pj4NCj4+PiBUaGlzIGNvbW1pdCBpbnRyb2R1Y2VzIGRpcmVjdCBk
YXRhIHBsYWNlbWVudCBvZmZsb2FkIHRvIE5WTUUNCj4+PiBUQ1AuIFRoZXJlIGlzIGEgY29udGV4
dCBwZXIgcXVldWUsIHdoaWNoIGlzIGVzdGFibGlzaGVkIGFmdGVyIHRoZQ0KPj4+IGhhbmRzaGFr
ZSB1c2luZyB0aGUgc2tfYWRkL2RlbCBORE9zLg0KPj4+DQo+Pj4gQWRkaXRpb25hbGx5LCBhIHJl
c3luY2hyb25pemF0aW9uIHJvdXRpbmUgaXMgdXNlZCB0byBhc3Npc3QNCj4+PiBoYXJkd2FyZSBy
ZWNvdmVyeSBmcm9tIFRDUCBPT08sIGFuZCBjb250aW51ZSB0aGUgb2ZmbG9hZC4NCj4+PiBSZXN5
bmNocm9uaXphdGlvbiBvcGVyYXRlcyBhcyBmb2xsb3dzOg0KPj4+DQo+Pj4gMS4gVENQIE9PTyBj
YXVzZXMgdGhlIE5JQyBIVyB0byBzdG9wIHRoZSBvZmZsb2FkDQo+Pj4NCj4+PiAyLiBOSUMgSFcg
aWRlbnRpZmllcyBhIFBEVSBoZWFkZXIgYXQgc29tZSBUQ1Agc2VxdWVuY2UgbnVtYmVyLA0KPj4+
IGFuZCBhc2tzIE5WTWUtVENQIHRvIGNvbmZpcm0gaXQuDQo+Pj4gVGhpcyByZXF1ZXN0IGlzIGRl
bGl2ZXJlZCBmcm9tIHRoZSBOSUMgZHJpdmVyIHRvIE5WTWUtVENQIGJ5IGZpcnN0DQo+Pj4gZmlu
ZGluZyB0aGUgc29ja2V0IGZvciB0aGUgcGFja2V0IHRoYXQgdHJpZ2dlcmVkIHRoZSByZXF1ZXN0
LCBhbmQNCj4+PiB0aGVuIGZpbmRpbmcgdGhlIG52bWVfdGNwX3F1ZXVlIHRoYXQgaXMgdXNlZCBi
eSB0aGlzIHJvdXRpbmUuDQo+Pj4gRmluYWxseSwgdGhlIHJlcXVlc3QgaXMgcmVjb3JkZWQgaW4g
dGhlIG52bWVfdGNwX3F1ZXVlLg0KPj4+DQo+Pj4gMy4gV2hlbiBOVk1lLVRDUCBvYnNlcnZlcyB0
aGUgcmVxdWVzdGVkIFRDUCBzZXF1ZW5jZSwgaXQgd2lsbCBjb21wYXJlDQo+Pj4gaXQgd2l0aCB0
aGUgUERVIGhlYWRlciBUQ1Agc2VxdWVuY2UsIGFuZCByZXBvcnQgdGhlIHJlc3VsdCB0byB0aGUN
Cj4+PiBOSUMgZHJpdmVyIChyZXN5bmMpLCB3aGljaCB3aWxsIHVwZGF0ZSB0aGUgSFcsIGFuZCBy
ZXN1bWUgb2ZmbG9hZA0KPj4+IHdoZW4gYWxsIGlzIHN1Y2Nlc3NmdWwuDQo+Pj4NCj4+PiBTb21l
IEhXIGltcGxlbWVudGF0aW9uIHN1Y2ggYXMgQ29ubmVjdFgtNyBhc3N1bWUgbGluZWFyIENDSUQg
KDAuLi5OLTENCj4+PiBmb3IgcXVldWUgb2Ygc2l6ZSBOKSB3aGVyZSB0aGUgbGludXggbnZtZSBk
cml2ZXIgdXNlcyBwYXJ0IG9mIHRoZSAxNg0KPj4+IGJpdCBDQ0lEIGZvciBnZW5lcmF0aW9uIGNv
dW50ZXIuIFRvIGFkZHJlc3MgdGhhdCwgd2UgdXNlIHRoZSBleGlzdGluZw0KPj4+IHF1aXJrIGlu
IHRoZSBudm1lIGxheWVyIHdoZW4gdGhlIEhXIGRyaXZlciBhZHZlcnRpc2VzIGlmIHRoZSBkZXZp
Y2UgaXMNCj4+PiBub3Qgc3VwcG9ydHMgdGhlIGZ1bGwgMTYgYml0IENDSUQgcmFuZ2UuDQo+Pj4N
Cj4+PiBGdXJ0aGVybW9yZSwgd2UgbGV0IHRoZSBvZmZsb2FkaW5nIGRyaXZlciBhZHZlcnRpc2Ug
d2hhdCBpcyB0aGUgbWF4IGh3DQo+Pj4gc2VjdG9ycy9zZWdtZW50cyB2aWEgdWxwX2RkcF9saW1p
dHMuDQo+Pj4NCj4+PiBBIGZvbGxvdy11cCBwYXRjaCBpbnRyb2R1Y2VzIHRoZSBkYXRhLXBhdGgg
Y2hhbmdlcyByZXF1aXJlZCBmb3IgdGhpcw0KPj4+IG9mZmxvYWQuDQo+Pj4NCj4+PiBTb2NrZXQg
b3BlcmF0aW9ucyBuZWVkIGEgbmV0ZGV2IHJlZmVyZW5jZS4gVGhpcyByZWZlcmVuY2UgaXMNCj4+
PiBkcm9wcGVkIG9uIE5FVERFVl9HT0lOR19ET1dOIGV2ZW50cyB0byBhbGxvdyB0aGUgZGV2aWNl
IHRvIGdvIGRvd24gaW4NCj4+PiBhIGZvbGxvdy11cCBwYXRjaC4NCj4+Pg0KPj4+IFNpZ25lZC1v
ZmYtYnk6IEJvcmlzIFBpc21lbm55IDxib3Jpc3BAbnZpZGlhLmNvbT4NCj4+PiBTaWduZWQtb2Zm
LWJ5OiBCZW4gQmVuLUlzaGF5IDxiZW5pc2hheUBudmlkaWEuY29tPg0KPj4+IFNpZ25lZC1vZmYt
Ynk6IE9yIEdlcmxpdHogPG9nZXJsaXR6QG52aWRpYS5jb20+DQo+Pj4gU2lnbmVkLW9mZi1ieTog
WW9yYXkgWmFjayA8eW9yYXl6QG52aWRpYS5jb20+DQo+Pj4gU2lnbmVkLW9mZi1ieTogU2hhaSBN
YWxpbiA8c21hbGluQG52aWRpYS5jb20+DQo+Pj4gU2lnbmVkLW9mZi1ieTogQXVyZWxpZW4gQXB0
ZWwgPGFhcHRlbEBudmlkaWEuY29tPg0KPj4+IFJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2Fy
bmkgPGtjaEBudmlkaWEuY29tPg0KPj4+IC0tLQ0KPj4NCj4+IEZvciBOVk1lIHJlbGF0ZWQgY29k
ZSA6LQ0KPj4NCj4+IE9mZmxvYWQgZmVhdHVyZSBpcyBjb25maWd1cmFibGUgYW5kIG1heWJlIG5v
dCBiZSB0dXJuZWQgb24gaW4gdGhlIGFic2VuY2UNCj4+IG9mIHRoZSBIL1cuIEluIG9yZGVyIHRv
IGtlZXAgdGhlIG52bWUvaG9zdC90Y3AuYyBmaWxlIHNtYWxsIHRvIG9ubHkgDQo+PiBoYW5kbGUN
Cj4+IGNvcmUgcmVsYXRlZCBmdW5jdGlvbmFsaXR5LCBJIHdvbmRlciBpZiB3ZSBzaG91bGQgdG8g
bW92ZSB0Y3Atb2ZmbG9hZCANCj4+IGNvZGUNCj4+IGludG8gaXQncyBvd24gZmlsZSBzYXkgbnZt
ZS9ob3N0L3RjcC1vZmZsb2FkLmMgPw0KPiANCj4gTWF5YmUuIGl0IHdvdWxkbid0IGJlIHRjcF9v
ZmZsb2FkLmMgYnV0IHJhdGhlciB0Y3BfZGRwLmMgYmVjYXVzZSBpdHMgbm90DQo+IG9mZmxvYWRp
bmcgdGhlIHRjcCBzdGFjayBidXQgcmF0aGVyIGRvaW5nIGRpcmVjdCBkYXRhIHBsYWNlbWVudC4N
Cj4NCg0KZmluZSAuLi4NCg0KPiBJZiB3ZSBhcmUgZ29pbmcgdG8gZG8gdGhhdCBpdCB3aWxsIHBv
bGx1dGUgbnZtZS5oIG9yIGFkZCBhIGNvbW1vbg0KPiBoZWFkZXIgZmlsZSwgd2hpY2ggaXMgc29t
ZXRoaW5nIEknZCBsaWtlIHRvIGF2b2lkIGlmIHBvc3NpYmxlLg0KDQpteSBjb21tZW50IHdhcyBt
YWlubHkgYmFzZWQgb24gaG93IHdlIHNlcGFyYXRlZCB0aGUgY29yZSBjb2RlIGZyb20NCmNvbmZp
Z3VyYWJsZSBmZWF0dXJlcywgYW5kIHdvbmRlcmluZyBhbnkgZGVjaXNpb24gd2UgbWFrZSBmb3Ig
aG9zdCB3aWxsDQphbHNvIGFwcGx5IGZvciB0aGUgdGFyZ2V0IGRkcCBjb2RlIGluIGZ1dHVyZSwg
YnV0IHlvdSBwcmVmZXIgdG8ga2VlcCBpdCANCmFzIGl0IGlzIGxldCdzIG5vdCBibG9hdCBoZWFk
ZXIgLi4uDQoNCi1jaw0KDQoNCg0K

